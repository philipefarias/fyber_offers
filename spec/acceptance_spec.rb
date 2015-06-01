require "helper"
require "capybara"
require "capybara_minitest_spec"
require "support/vcr"
require "web"

describe "listing offers" do
  include Capybara::DSL

  before do
    Capybara.app = FyberOffers::Web.new
  end

  after do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  it "shows that there's no offers" do
    with_no_offers do
      visit "/"

      within "#offers" do
        page.wont_have_css(".offer")
      end
    end
  end

  it "shows a list of offers" do
    with_offers do
      visit "/"

      within "#offers" do
        page.must_have_css(".offer", count: 22)
      end
    end
  end
end
