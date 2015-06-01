require "sinatra/base"
require "yaml"
require_relative "client"

module FyberOffers
  class Web < Sinatra::Base
    configure do
      set :views, settings.root + '/templates'
    end

    get "/" do
      erb :index, locals: { offers: fetch_offers }
    end

    private

    def fetch_offers
      Fetcher.new.call
    end
  end

  class Fetcher
    def call
      client.call
    end

    private

    def client
      FyberOffers::Client.new url: api(:url),
                              key: api(:key),
                              params: api(:params)
    end

    def api(key)
      config[key.to_s]
    end

    def config
      @config ||= YAML.load file
    end

    def file
      File.read(File.expand_path("../../api.yml", __FILE__))
    end
  end
end
