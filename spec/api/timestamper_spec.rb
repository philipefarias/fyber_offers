require "helper"
require "support/timecop"
require "api/timestamper"

describe FyberOffers::API::Timestamper do
  it "returns an unix timestamp" do
    at_a_fixed_time do
      FyberOffers::API::Timestamper.call.must_equal 1433112900
    end
  end
end
