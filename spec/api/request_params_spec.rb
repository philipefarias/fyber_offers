require_relative "../helper"
require "lib/api/request_params"

describe FyberOffers::API::RequestParams do
  let(:params) { {"uid" => 1, "appid" => 157} }
  let(:request_params) { FyberOffers::API::RequestParams.new params }

  describe "#to_h" do
    it "returns the params hash with keys symbolized" do
      symbolized_params = { uid: 1, appid: 157 }
      request_params.to_h.must_equal symbolized_params
    end
  end

  describe "#to_s" do
    it "returns the params as query string" do
      query_string = "uid=1&appid=157"
      request_params.to_s.must_equal query_string
    end
  end

  describe "#[]=" do
    it "stores new value with key as symbol" do
      expected = { uid: 1, appid: 157, locale: "de" }

      request_params["locale"] = "de"

      request_params.to_h.must_equal expected
    end
  end

  describe "#assert_keys_presence" do
    it "returns an error when there is a key missing" do
      proc {
        request_params.assert_keys_presence :uid, :locale
      }.must_raise FyberOffers::API::MissingAttribute
    end

    it "returns true when there isn't a key missing" do
      request_params.assert_keys_presence(:uid, :appid).must_equal true
    end

    it "accepts an array of keys as argumments" do
      request_params.assert_keys_presence([:uid, :appid]).must_equal true
    end
  end

  describe "#assert_values_presence" do
    it "returns an error when there is a blank value" do
      proc {
        request_params = FyberOffers::API::RequestParams.new uid: 1, appid: 157, locale: ""
        request_params.assert_values_presence
      }.must_raise FyberOffers::API::MissingAttribute
    end

    it "returns true when there isn't a blank value" do
      request_params.assert_values_presence.must_equal true
    end
  end

  describe "#delete_blanks" do
    it "remove params with blank values" do
      params_with_blank = { uid: 1, appid: 157, locale: "" }
      request_params = FyberOffers::API::RequestParams.new params_with_blank

      request_params.delete_blanks.to_h.must_equal uid: 1, appid: 157
    end
  end
end
