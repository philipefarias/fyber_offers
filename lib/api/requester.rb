require "net/http"
require "uri"

module FyberOffers
  module API

    class Requester
      attr_reader :url, :http_client

      def initialize(url, http_client: Net::HTTP)
        @url         = url
        @http_client = http_client
      end

      def call
        http_client.get URI(url)
      end
    end

  end
end
