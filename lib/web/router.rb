require "sinatra/base"

module FyberOffers
  module Web

    class Router < Sinatra::Base
      configure do
        enable :sessions
        set :views, settings.root + '/templates'
        set :erb, escape_html: true
      end

      get "/" do
        offers = REPO.get session["id"]
        erb :index, locals: { offers: offers }
      end

      post "/" do
        session["id"] = REPO.put fetch_offers
        redirect to("/")
      end

      private

      def fetch_offers
        if params && !params.empty? && params["uid"]
          Fetcher.new(params).call
        else
          []
        end
      end
    end

  end
end
