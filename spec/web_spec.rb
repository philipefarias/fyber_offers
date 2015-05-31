require "helper"
require "rack/test"
require "web"

describe FyberOffers::Web do
  include Rack::Test::Methods

  def app
    FyberOffers::Web.new
  end

  it "renders the page" do
    get "/"

    last_response.must_be :ok?
    last_response["Content-Type"].must_equal "text/html;charset=utf-8"
    last_response.body.must_equal "Fyber Offers"
  end

  it "renders nothing for unknown page" do
    get "/unknown"

    last_response.wont_be :ok?
    last_response["Content-Type"].must_equal "text/html;charset=utf-8"
    last_response.body.must_equal ""
  end
end
