require "bundler/setup"
require "minitest/spec"
require "minitest/autorun"
require "minitest/reporters"
require "rr"

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]

$:.unshift File.expand_path "../..", __FILE__
