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
    visit "/"
    page.must_have_content "No offers available"
  end

  it "shows a list of offers when there's some" do
    fetcher = -> { [{title: "I'm an offer!"}] }
    stub(FyberOffers::Fetcher).new { fetcher }

    visit "/"

    within "#offers" do
      page.must_have_content "I'm an offer!"
    end
  end
end
