require "./lib/web"
require "sass/plugin/rack"

use Sass::Plugin::Rack

run FyberOffers::Web.app
