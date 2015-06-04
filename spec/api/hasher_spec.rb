require_relative "../helper"
require "lib/api/hasher"

describe FyberOffers::API::Hasher do
  it "calculates the hashkey" do
    key      = "to_happiness"
    params   = [ "api_id=157", "uid=1", "locale=de" ]
    digester = -> (arg) { "!!!#{arg}!!!" }

    hasher = FyberOffers::API::Hasher.new key: key,
                                          params: params,
                                          digester: digester

    hasher.call.must_equal "!!!api_id=157&locale=de&uid=1&to_happiness!!!"
  end
end
