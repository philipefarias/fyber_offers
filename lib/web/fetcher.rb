module FyberOffers
  module Web

    class Fetcher
      attr_reader :client, :configs
      attr_accessor :params

      def initialize(params = {}, options: {})
        @configs = options.fetch(:configs, Web.config(:api))
        @client  = options.fetch(:client,  Web.api)
        @params  = default_params.merge params
      end

      def call
        client.call(params) || []
      end

      private

      def default_params
        configs["params"].to_h
      end
    end

  end
end
