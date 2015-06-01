require "helper"
require "support/vcr"
require "support/timecop"
require "api"

VCR.configure do |config|
  config.default_cassette_options = {
    match_requests_on: [ :method ]
  }
end

describe FyberOffers::API::Client do
  let(:timestamper) { proc { 1433016415 } }
  let(:api_url) { "http://api.example.com/offers" }
  let(:api_key) { "dedb9f9901d4859e5c9b" }

  let(:params) do
    {
      uid: 1,
      appid: 157,
      device_id: "2b6f0cc904d137be",
      locale: "de"
    }
  end

  def new_client(url:, key:, params:)
    FyberOffers::API::Client.new url: url, key: key, params: params
  end

  def hash_except(hash, key)
    hash.dup.tap { |h| h.delete(key) }
  end

  describe "presence validations" do
    it "returns an error when there's no uid" do
      proc {
        new_client(url: api_url, key: api_key, params: hash_except(params, :uid))
      }.must_raise FyberOffers::API::Error::MissingAttribute
    end

    it "returns an error when there's no device_id" do
      proc {
        new_client(url: api_url, key: api_key, params: hash_except(params, :device_id))
      }.must_raise FyberOffers::API::Error::MissingAttribute
    end

    it "returns an error when there's no locale" do
      proc {
        new_client(url: api_url, key: api_key, params: hash_except(params, :locale))
      }.must_raise FyberOffers::API::Error::MissingAttribute
    end

    it "returns an error when uid is blank" do
      proc {
        new_client(url: api_url, key: api_key, params: params.merge(uid: nil))
      }.must_raise FyberOffers::API::Error::MissingAttribute
    end

    it "returns an error when device_id is blank" do
      proc {
        new_client(url: api_url, key: api_key, params: params.merge(device_id: ""))
      }.must_raise FyberOffers::API::Error::MissingAttribute
    end

    it "returns an error when locale is blank" do
      proc {
        new_client(url: api_url, key: api_key, params: params.merge(locale: ""))
      }.must_raise FyberOffers::API::Error::MissingAttribute
    end
  end

  describe "#call" do
    it "returns the response body" do
      with_offers any_url: true do
        client = new_client url: api_url, key: api_key, params: params
        client.call.must_be_kind_of Array
      end
    end
  end

  describe "#url" do
    it "returns the request url for json as default" do
      at_a_fixed_time do
        client = new_client url: api_url, key: api_key, params: params
        client.url.must_equal "http://api.example.com/offers.json?uid=1&appid=157&device_id=2b6f0cc904d137be&locale=de&timestamp=1433112900&hashkey=37e03692746565c2c8444bf00a9a83f7de24e038"
      end
    end
  end
end