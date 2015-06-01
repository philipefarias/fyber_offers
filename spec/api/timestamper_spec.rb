require "helper"
require "timecop"
require "api/timestamper"

describe FyberOffers::API::Timestamper do
  before do
    Timecop.freeze Time.local(2015, 5, 31, 19, 55, 0)
  end

  after do
    Timecop.return
  end

  it "returns an unix timestamp" do
    FyberOffers::API::Timestamper.call.must_equal 1433112900
  end
end
