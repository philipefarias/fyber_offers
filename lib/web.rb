require "sinatra/base"

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
      []
    end
  end
end
