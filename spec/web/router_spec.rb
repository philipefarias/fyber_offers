require_relative "../helper"
require_relative "../support/capybara"
require "lib/web"

describe FyberOffers::Web::Router do
  include Capybara::DSL

  before do
    Capybara.app = FyberOffers::Web.app
  end

  after do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  let :offer do
    {
      :title => "I'm an offer!",
      :teaser => "I'm a teaser",
      :link => "example.com/offer",
      :payout => 89358,
      :thumbnail => { :lowres => "image.jpg" },
      :time_to_payout => { :readable => "8 minutes" },
      :offer_types => [
        { :readable => "Free"  }
      ]
    }
  end

  describe "GET '/'" do
    it "shows a message when there's none" do
      stub(FyberOffers::Web::REPO).get { [] }

      visit "/"

      page.must_have_content "No offers available"
    end

    it "shows a list of offers when there's some" do
      stub(FyberOffers::Web::REPO).get { [offer] }

      visit "/"

      page.must_have_content "I'm an offer!"
    end
  end
end
