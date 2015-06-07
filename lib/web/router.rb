require "sinatra/base"

using FyberOffers::Utils

module FyberOffers
  module Web

    class Router < Sinatra::Base
      configure do
        set :views, settings.root + '/templates'
        set :erb, escape_html: true
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
          if collection = options.delete(:collection)
            collection.inject([]) do |buffer, member|
              buffer << erb(template, options.merge(locals: { template.to_sym => member }))
            end.join("\n")
          else
            erb(template, options)
          end
        end
      end

      get "/" do
        @form   = OffersForm.new
        @offers = []
        erb :index
      end

      post "/" do
        @form   = OffersForm.new params
        @offers = @form.submit
        erb :index
      end
    end

  end
end
