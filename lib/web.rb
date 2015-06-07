ENV["RACK_ENV"] ||= "development"

require_relative "api"
require_relative "utils"
require_relative "web/offers_form"
require_relative "web/fetcher"
require_relative "web/router"
require "yaml"
require "dotenv"

Dotenv.load(
    File.expand_path("../../.#{ENV["RACK_ENV"]}.env", __FILE__),
    File.expand_path("../../.env",  __FILE__)
)


module FyberOffers
  module Web

    CONFIG_FILE_PATH = File.expand_path("../../config.yml", __FILE__)
    CONFIG = YAML.load File.read(CONFIG_FILE_PATH)

    def app
      Router.new
    end
    module_function :app

    def api
      url = config :api_url
      key = ENV["API_KEY"]
      FyberOffers::API::Client.new url: url, key: key
    end
    module_function :api

    def config(key)
      CONFIG[key.to_s]
    end
    module_function :config

  end
end
