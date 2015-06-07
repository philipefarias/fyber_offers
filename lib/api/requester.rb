require "net/http"
require "uri"

module FyberOffers
  module API

    class Requester
      attr_reader :base_url, :response_handler, :http_client

      def initialize(base_url, response_handler: Response, http_client: CurbAdapter)
        @base_url         = base_url
        @response_handler = response_handler
        @http_client      = http_client.new
      end

      def call(params)
        response_from get(params)
      end

      private

      def response_from(response_body)
        response_handler.new response_body
      end

      def get(params)
        http_client.get url_for(params)
      end

      def url_for(params)
        "#{base_url}?#{params}"
      end
    end

  end
end
