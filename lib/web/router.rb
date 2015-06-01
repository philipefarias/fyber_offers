require "sinatra/base"

module FyberOffers
  module Web

    class Router < Sinatra::Base
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

  end
end
