require "helper"
require "digest/sha1"
require "api/digester"

describe FyberOffers::API::Digester do
  it "encodes a string with SHA1" do
    a_string = "digest me!"
    FyberOffers::API::Digester.call(a_string).must_equal "ef59a36f6765a838efb8e44a0587f340158344cd"
  end
end
