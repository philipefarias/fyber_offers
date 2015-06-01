require "helper"
require 'webmock/minitest'
require "api/requester"

describe FyberOffers::API::Requester do
  it "makes the request" do
    url  = "http://www.example.com"
    body = '{"offers" : [{"title" : "offer yo"}]}'

    stub_request(:get, url).to_return(body: body)

    requester = FyberOffers::API::Requester.new url
    requester.call.must_equal JSON.parse(body)
  end
end
