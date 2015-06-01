require_relative "api"
require_relative "web/fetcher"
require_relative "web/router"
require "yaml"

module FyberOffers
  module Web
    CONFIG_FILE_PATH = File.expand_path("../../config.yml", __FILE__)
    CONFIG = YAML.load File.read(CONFIG_FILE_PATH)

    def app
      Router.new
    end
    module_function :app

    def api
      -> (args) { FyberOffers::API::Client.new(args).call }
    end
    module_function :api

    def config(key)
      CONFIG[key.to_s]
    end
    module_function :config

  end
end
