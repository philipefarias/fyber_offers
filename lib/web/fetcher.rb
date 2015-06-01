module FyberOffers
  module Web

    class Fetcher
      attr_reader :client, :configs
      attr_accessor :params

      def initialize(params = {}, options: {})
        @configs = options.fetch(:configs, Web.config(:api))
        @client  = options.fetch(:client,  Web.api)
        @params  = conf(:params).to_h.merge params
      end

      def call
        client.call api_args
      end

      private

      def api_args
        {
          url: conf(:url),
          key: conf(:key),
          params: params
        }
      end

      def conf(key)
        configs && configs[key.to_s]
      end
    end

  end
end
