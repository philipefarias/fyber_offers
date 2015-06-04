require "net/http"
require "uri"

module FyberOffers
  module API

    class Requester
      attr_reader :url, :response_handler, :http_client

      def initialize(url, response_handler: Response, http_client: Net::HTTP)
        @url         = url
        @http_client = http_client
        @response_handler = response_handler
      end

      def call
        response_from get_url
      end

      private

      def response_from(response_body)
        response_handler.new response_body
      end

      def get_url
        http_client.get URI(url)
      end
    end

  end
end
