require "helper"
require "capybara"
require "capybara_minitest_spec"
require "web"

describe FyberOffers::Web do
  include Capybara::DSL

  before do
    Capybara.app = FyberOffers::Web.new
  end

  after do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  it "shows a message when there's none" do
    fetcher = -> { [] }
    stub(FyberOffers::Fetcher).new { fetcher }

    visit "/"

    page.must_have_content "No offers available"
  end

  it "shows a list of offers when there's some" do
    fetcher = -> { [offer] }
    stub(FyberOffers::Fetcher).new { fetcher }

    visit "/"

    page.must_have_content "I'm an offer!"
  end

  let :offer do
    {
      "title" => "I'm an offer!",
      "teaser" => "I'm a teaser",
      "link" => "example.com/offer",
      "payout" => 89358,
      "thumbnail" => { "lowres" => "image.jpg" },
      "time_to_payout" => { "readable" => "8 minutes" },
      "offer_types" => [
        { "readable" => "Free"  }
      ]
    }
  end
end
