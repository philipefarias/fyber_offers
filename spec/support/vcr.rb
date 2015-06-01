require "webmock"
require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "./spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.default_cassette_options = {
    match_requests_on: [
      :method,
      VCR.request_matchers.uri_without_params(:ps_time, :timestamp, :hashkey)
    ]
  }
end

def with_no_offers(options = {}, &block)
  use_vcr "no_offers", options, &block
end

def with_offers(options = {}, &block)
  use_vcr "offers", options, &block
end

def use_vcr(cassette, options = {}, &block)
  options[:match_requests_on] = [:method] if options.delete(:any_url)

  VCR.use_cassette cassette, options, &block
end
