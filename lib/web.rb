require "sinatra/base"

module FyberOffers
  class Web < Sinatra::Base
    configure do
      set :views, settings.root + '/templates'
    end

    get "/" do
      erb :index
    end
  end
end
