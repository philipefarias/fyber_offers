require_relative "../helper"
require "lib/api/requester"

describe FyberOffers::API::Requester do
  class HTTPDummy
    def self.get(uri)
      "body content"
    end
  end

  it "gets the uri" do
    url  = "http://www.example.com"

    requester = FyberOffers::API::Requester.new url, http_client: HTTPDummy
    requester.call.must_equal "body content"
  end
end
