require "helper"
require "web"

describe FyberOffers::Web::Fetcher do
  let(:fake_client) do
    -> (args) { args[:params].empty? ? ["default offer"] : ["custom offer"] }
  end

  let(:api_conf) do
    { "url" => "example.com", "key" => "random", "params" => {} }
  end

  def new_fetcher(params = {})
    FyberOffers::Web::Fetcher.new params, options: {
      client: fake_client,
      configs: api_conf
    }
  end

  it "fetches offers with config params" do
    new_fetcher.call.must_equal ["default offer"]
  end

  it "fetches offers with custom params" do
    new_fetcher(uid: 37).call.must_equal ["custom offer"]
  end
end
