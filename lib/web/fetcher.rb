using FyberOffers::Utils

module FyberOffers
  module Web

    class Fetcher
      attr_reader :client, :default_params
      attr_accessor :params

      def initialize(params = {})
        options  = params.delete(:options) || {}
        @default_params = options.fetch(:configs, Web.config(:params))
        @client  = options.fetch(:client,  Web.api)
        @params  = default_params.merge params.select {|_,v| v.present?}
      end

      def call
        client.call(params) || []
      end
    end

  end
end
