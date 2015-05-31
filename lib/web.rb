require "sinatra/base"

module FyberOffers
  class Web < Sinatra::Base
    template :index do
      "No offers available"
    end

    get "/" do
      erb :index
    end
  end
end
