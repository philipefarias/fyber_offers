require_relative "../helper"
require "lib/api/requester"

describe FyberOffers::API::Requester do
  class HTTPDummy
    def get(_)
      "body content"
    end
  end

  class DummyResponse < Struct.new(:body)
  end

  let :requester do
    FyberOffers::API::Requester.new "http://www.example.com",
                                    http_client: HTTPDummy,
                                    response_handler: DummyResponse
  end

  let :dummy_response do
    DummyResponse.new "body content"
  end

  it "gets the uri and wraps the response" do
    params = {uid: 1}
    requester.call(params).must_equal dummy_response
  end
end
