require_relative "../helper"
require "lib/api/response"

describe FyberOffers::API::Response do
  let :response do
    new_response json_response
  end

  let :json_response do
    %{{ "code" : "OK", "message" : "OK!", "count" : "43", "pages" : "2" }}
  end

  def new_response(json)
    FyberOffers::API::Response.new json
  end

  describe "#body" do
    it "returns parsed json" do
      response.body.must_equal "code" => "OK", "message" => "OK!", "count" => "43", "pages" => "2"
    end
  end

  describe "#code" do
    it "returns the response code" do
      response.code.must_equal "OK"
    end
  end

  describe "#message" do
    it "returns the response message" do
      response.message.must_equal "OK!"
    end
  end

  describe "#count" do
    it "returns the response pages number" do
      response.count.must_equal 43
    end
  end

  describe "#pages" do
    it "returns the response pages number" do
      response.pages.must_equal 2
    end
  end

  describe "parsing response" do
    it "raises exception for blank body" do
      proc {
        new_response %{{ }}
      }.must_raise FyberOffers::API::Error::InvalidResponse
    end

    it "raises exception for blank code" do
      proc {
        new_response %{{ "code" : "" }}
      }.must_raise FyberOffers::API::Error::InvalidResponse
    end

    it "raises exception for invalid page error" do
      proc {
        new_response %{{ "code" : "ERROR_INVALID_PAGE" }}
      }.must_raise FyberOffers::API::Error::InvalidPage
    end

    it "raises exception for invalid appid error" do
      proc {
        new_response %{{ "code" : "ERROR_INVALID_APPID" }}
      }.must_raise FyberOffers::API::Error::InvalidAppid
    end

    it "raises exception for invalid uid error" do
      proc {
        new_response %{{ "code" : "ERROR_INVALID_UID" }}
      }.must_raise FyberOffers::API::Error::InvalidUid
    end

    it "raises exception for invalid hashkey error" do
      proc {
        new_response %{{ "code" : "ERROR_INVALID_HASHKEY" }}
      }.must_raise FyberOffers::API::Error::InvalidHashkey
    end

    it "raises exception for invalid device_id error" do
      proc {
        new_response %{{ "code" : "ERROR_INVALID_DEVICE_ID" }}
      }.must_raise FyberOffers::API::Error::InvalidDeviceId
    end

    it "raises exception for invalid ip error" do
      proc {
        new_response %{{ "code" : "ERROR_INVALID_IP" }}
      }.must_raise FyberOffers::API::Error::InvalidIp
    end

    it "raises exception for invalid timestamp error" do
      proc {
        new_response %{{ "code" : "ERROR_INVALID_TIMESTAMP" }}
      }.must_raise FyberOffers::API::Error::InvalidTimestamp
    end

    it "raises exception for invalid locale error" do
      proc {
        new_response %{{ "code" : "ERROR_INVALID_LOCALE" }}
      }.must_raise FyberOffers::API::Error::InvalidLocale
    end

    it "raises exception for invalid android_id error" do
      proc {
        new_response %{{ "code" : "ERROR_INVALID_ANDROID_ID" }}
      }.must_raise FyberOffers::API::Error::InvalidAndroidId
    end

    it "raises exception for invalid category error" do
      proc {
        new_response %{{ "code" : "ERROR_INVALID_CATEGORY" }}
      }.must_raise FyberOffers::API::Error::InvalidCategory
    end

    it "raises exception for server error" do
      proc {
        new_response %{{ "code" : "ERROR_INTERNAL_SERVER_ERROR" }}
      }.must_raise FyberOffers::API::Error::RemoteServerError
    end

    it "raises exception for unknown code" do
      proc {
        new_response %{{ "code" : "SOME_RANDOM_CODE" }}
      }.must_raise FyberOffers::API::Error::UnknownCode
    end

  end
end
