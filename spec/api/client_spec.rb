require_relative "../helper"
require_relative "../support/vcr"
require "lib/api"

using FyberOffers::Utils

describe FyberOffers::API::Client do
  let(:api_url) { "http://api.example.com/offers" }
  let(:api_key) { "dedb9f9901d4859e5c9b" }
  let(:client)  { FyberOffers::API::Client.new url: api_url, key: api_key }

  let(:params) do
    {
      uid: 1,
      appid: 157,
      device_id: "2b6f0cc904d137be",
      locale: "de"
    }
  end

  describe "presence validations" do
    it "returns an error when there's no uid" do
      proc {
        client.call params.except(:uid)
      }.must_raise FyberOffers::API::Error::MissingAttribute
    end

    it "returns an error when there's no device_id" do
      proc {
        client.call params.except(:device_id)
      }.must_raise FyberOffers::API::Error::MissingAttribute
    end

    it "returns an error when there's no locale" do
      proc {
        client.call params.except(:locale)
      }.must_raise FyberOffers::API::Error::MissingAttribute
    end

    it "returns an error when uid is blank" do
      proc {
        client.call params.merge(uid: nil)
      }.must_raise FyberOffers::API::Error::MissingAttribute
    end

    it "returns an error when device_id is blank" do
      proc {
        client.call params.merge(device_id: "")
      }.must_raise FyberOffers::API::Error::MissingAttribute
    end

    it "returns an error when locale is blank" do
      proc {
        client.call params.merge(locale: "")
      }.must_raise FyberOffers::API::Error::MissingAttribute
    end
  end

  describe "#call" do
    it "returns the response body" do
      with_offers any_url: true do
        client.call(params).must_be_kind_of Array
      end
    end
  end
end
