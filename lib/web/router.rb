require "sinatra/base"

using FyberOffers::Utils

module FyberOffers
  module Web

    class Router < Sinatra::Base
      configure do
        enable :sessions
        set :views, settings.root + '/templates'
        set :erb, escape_html: true
        set :scss, style: :compressed, debug_info: false
      end

      helpers do
        # Render the page once:
        # Usage: partial :foo
        #
        # foo will be rendered once for each element in the array, passing in a local
        # variable named "foo"
        # Usage: partial :foo, :collection => @my_foos

        def partial(template, *args)
          options = args.extract_options!
          options.merge!(layout: false)
          if collection = options.delete(:collection) then
            collection.inject([]) do |buffer, member|
              buffer << erb(template, options.merge(
                                         layout: false,
                                         locals: { template.to_sym => member }
                                     )
              )
            end.join("\n")
          else
            erb(template, options)
          end
        end
      end

      get "/" do
        offers = REPO.get session["id"]
        erb :index, locals: { offers: offers }
      end

      post "/" do
        session["id"] = REPO.put fetch_offers
        redirect to("/")
      end

      get "/css/:name.css" do |name|
        content_type :css
        scss "css/#{name}".to_sym, :layout => false
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
