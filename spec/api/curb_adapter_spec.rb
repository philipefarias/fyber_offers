require_relative "../helper"
require "lib/api/curb_adapter"

describe FyberOffers::API::CurbAdapter do
  class DummyCurb
    attr_writer :encoding, :url

    def perform
      true
    end

    def body_str
      %{{ "encoding" : "#{@encoding}", "url" : "#{@url}", "body" : "success" }}
    end
  end

  it "sets the encoding, the url and returns the body" do
    expected = %{{ "encoding" : "gzip, deflate", "url" : "http://example.com", "body" : "success" }}
    adapter = FyberOffers::API::CurbAdapter.new curb_class: DummyCurb
    adapter.get("http://example.com").must_equal expected
  end
end