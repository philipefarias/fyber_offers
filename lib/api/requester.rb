require "net/http"
require "json"
require "uri"

module FyberOffers
  module API

    class Requester
      attr_reader :url

      def initialize(url)
        @url = url
      end

      def call
        JSON.parse get(url)
      end

      private

      def get(url)
        Net::HTTP.get URI(url)
      end
    end

  end
end
