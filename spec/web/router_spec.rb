require_relative "../helper"
require "lib/web"

describe FyberOffers::Web::Router do
  include Rack::Test::Methods

  let :app do
    FyberOffers::Web.app
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
    it "shows a message saying there's no offers" do
      get "/"

      last_response.body.must_have_content "No offers available"
    end
  end

  describe "POST '/'" do
    it "shows a list of offers when there's some" do
      stub.proxy(FyberOffers::Web::OffersForm).new do |obj|
        stub(obj).submit { [offer] }
      end

      post "/", uid: 1

      last_response.body.must_have_content "I'm an offer!"
    end
  end
end
