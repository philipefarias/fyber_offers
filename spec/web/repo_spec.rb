require "helper"
require "web/repo"

describe FyberOffers::Web::Repo do
  let(:repo) { FyberOffers::Web::Repo.new }

  it "returns an uuid when putting a record" do
    uuid_regex = /\A[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[34][0-9a-fA-F]{3}-[89ab][0-9a-fA-F]{3}-[0-9a-fA-F]{12}\z/
    repo.put([]).must_match uuid_regex
  end

  it "returns an empty array when the id is not found" do
    repo.get("wrong-id").must_equal []
  end
end
