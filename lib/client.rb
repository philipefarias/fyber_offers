module FyberOffers
  class Offer
  end

  class Client
    def initialize(options)
    end

    def call
      {}
    end

    def url
      "http://api.example.com/offers.json" + "?" + params
    end

    private

    def params
      "api_key=dedb9f9901d4859e5c9b&user_id=1&app_id=157"
    end
  end
end
