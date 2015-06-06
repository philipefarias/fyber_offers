require_relative "helper"
require "lib/utils"

using FyberOffers::Utils

describe "Object#blank?" do
  it "must be true for blank values" do
    blank_values   = [ nil, false, "", "   ", "  \n\t  \r ", [], {}, // ]

    blank_values.each do |blank|
      blank.blank?.must_equal true
    end
  end

  it "must be false for non blank values" do
    present_values = [ Object.new, true, 0, 1, "a", [nil], { nil => nil } ]

    present_values.each do |present|
      present.blank?.must_equal false
    end
  end
end

describe "Array#extract_options" do
  it "returns the last element if its a hash" do
    array   = [:a, :b, c: { d: "e"}]

    options = array.extract_options

    array.must_equal [:a, :b, c: { d: "e"}]
    options.must_equal c: { d: "e" }
  end

  it "returns a blank hash if last element isn't a hash" do
    array   = [:a, :b, :c]

    options = array.extract_options

    array.must_equal [:a, :b, :c]
    options.must_equal Hash.new
  end
end

describe "Array#extract_options!" do
  it "removes and returns the last element if its a hash" do
    array   = [:a, :b, c: { d: "e"}]

    options = array.extract_options!

    array.must_equal [:a, :b ]
    options.must_equal c: { d: "e" }
  end

  it "returns a blank hash if last element isn't a hash" do
    array   = [:a, :b, :c]

    options = array.extract_options!

    array.must_equal [:a, :b, :c]
    options.must_equal Hash.new
  end
end

describe "Hash#except" do
  it "returns a hash without given keys" do
    original = { a: "b", c: "d", e: "f" }
    expected = { :c  => "d" }

    new_hash = original.except(:a, :e)

    new_hash.must_equal expected
    original.wont_equal expected
  end
end

describe "Hash#except!" do
  it "deletes the hash keys in place" do
    original = { a: "b", c: "d", e: "f" }
    expected = { :c  => "d" }

    original.except!(:a, :e)

    original.must_equal expected
  end
end

describe "Hash#symbolize_keys" do
  it "returns a hash with the keys as symbol" do
    original = { "a" => "b", "c" => "d" }
    expected = { :a  => "b", :c  => "d" }

    new_hash = original.symbolize_keys

    new_hash.must_equal expected
    original.wont_equal expected
  end
end

describe "Hash#symbolize_keys!" do
  it "transforms the keys to symbol in place" do
    original = { "a" => "b", "c" => "d" }
    expected = { :a  => "b", :c  => "d" }

    original.symbolize_keys!

    original.must_equal expected
  end
end
