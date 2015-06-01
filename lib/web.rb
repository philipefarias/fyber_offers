require_relative "api"
require_relative "web/fetcher"
require_relative "web/router"

module FyberOffers
  module Web

    def app
      Router.new
    end
    module_function :app

  end
end
