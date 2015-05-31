require "helper"
require "client"

# FyberOffers::Client.new api_url: url,
#                         api_key: key,
#                         format: json,
#                         user_id: uid,
#                         app_id: 157,
#                         device_id: "2b6f0cc904d137be2e1730235f5664094b83",
#                         locale: de,
#                         ip: "109.235.143.113",
#                         offer_types: 112

describe FyberOffers::Client do
  describe "#call" do
    it "returns the response body" do
      client = FyberOffers::Client.new api_url: "http://api.example.com/offers",
                                       api_key: "dedb9f9901d4859e5c9b",
                                       user_id: 1,
                                       app_id: 157

      client.call.must_be_kind_of Hash
    end
  end

  describe "#url" do
    it "returns the request url for json as default" do
      client = FyberOffers::Client.new api_url: "http://api.example.com/offers",
                                       api_key: "dedb9f9901d4859e5c9b",
                                       user_id: 1,
                                       app_id: 157

      client.url.must_equal "http://api.example.com/offers.json?api_key=dedb9f9901d4859e5c9b&user_id=1&app_id=157"
    end
  end
end
