source "https://rubygems.org"
ruby "2.2.2"

gem "rake"
gem "sinatra"
gem "curb"

group :development, :test do
  gem "dotenv"
end

group :development do
  gem "pry"
end

group :test do
  gem "rack-test"
  gem "minitest-reporters"
  gem "capybara_minitest_spec"
  gem "rr", require: false
  gem "timecop"
  gem "webmock"
  gem "vcr"
end
