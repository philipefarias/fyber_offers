require "helper"
require "capybara"
require "capybara_minitest_spec"
require "web"

describe FyberOffers::Web do
  include Capybara::DSL

  before do
    Capybara.app = FyberOffers::Web.new
    visit "/"
  end

  after do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  it "it shows a message when there's none" do
    page.must_have_content "No offers available"
  end
end
