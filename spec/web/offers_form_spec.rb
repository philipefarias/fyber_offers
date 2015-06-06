require_relative "../helper"
require "lib/web/offers_form"

describe FyberOffers::Web::OffersForm do
  def new_form(params = {})
    FyberOffers::Web::OffersForm.new params, fetcher: DummyFetcher
  end

  it "instantiates inputs with default values" do
    expected = [
        { name: :uid,  type: :text,   value: nil, required: true },
        { name: :pub0, type: :text,   value: nil, required: false },
        { name: :page, type: :number, value: nil, required: false }
    ]

    form_inputs = new_form.inputs.map(&:to_h)

    form_inputs.must_equal expected
  end

  it "assign params to inputs values" do
    params   = { "uid" => "13", "pub0" => "campaign2", "page" => "47" }
    expected = [
        { name: :uid,  type: :text,   value: "13",        required: true },
        { name: :pub0, type: :text,   value: "campaign2", required: false },
        { name: :page, type: :number, value: "47",        required: false }
    ]

    form_inputs = new_form(params).inputs.map(&:to_h)

    form_inputs.must_equal expected
  end

  describe "#submit" do
    it "returns a collection of offers" do
      params = { "uid" => "13", "pub0" => "campaign2", "page" => "47" }
      form   = new_form params

      form.submit.must_equal ["offer"]
    end

    it "returns an empty collection if uid isn't present" do
      params = { "uid" => "", "pub0" => "campaign2", "page" => "47" }
      form   = new_form params

      form.submit.must_equal []
    end

    it "returns an empty collection if page isn't a number" do
      params = { "uid" => "13", "pub0" => "campaign2", "page" => "notanumber" }
      form   = new_form params

      form.submit.must_equal []
    end
  end

  describe "#error_messages" do
    it "returns an empty collection before submit" do
      form = new_form "uid" => ""
      form.error_messages.must_equal []
    end

    it "returns an collection of messages after submit" do
      form = new_form "uid" => ""
      form.submit
      form.error_messages.must_equal ["uid can't be blank"]
    end
  end

  class DummyFetcher
    def initialize(_)
    end

    def call
      ["offer"]
    end
  end
end