require "helper"
require "capybara"
require "capybara_minitest_spec"
require "support/vcr"
require "web"

describe "listing offers" do
  include Capybara::DSL

  before do
    Capybara.app = FyberOffers::Web.app
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

        page.must_have_xpath("//img[@src=\"http://cdn1.sponsorpay.com/assets/2690/appleprdodukty_square_60.PNG\"]")
        page.must_have_content "Nimm teil und gewinne!"
        page.must_have_content "Nimm mit deinen korrekten Daten am Gewinnspiel teil."
        page.must_have_content "Gratis"
        page.must_have_link "+ 80715", href: "http://offer.fyber.com/mobile?impression=true&appid=157&uid=1&client=api&platform=web&appname=Demo+iframe+for+publisher+-+do+not+touch&traffic_source=offer_api&country_code=DE&pubid=249&ip=109.235.143.113&device_id=2b6f0cc904d137be2e1730235f5664094b83&flash_cookie=bf891d35b19e5e5fe23c64b1a31caf88&ad_id=387469&ad_format=offer&sig=f9f9d7892adefd0fa29f6e7fbf2c23d1eead6547"
      end
    end
  end
end
