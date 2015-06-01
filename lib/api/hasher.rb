module FyberOffers
  module API

    class Hasher
      def initialize(key:, params:, digester: Digester)
        @key      = key
        @params   = params
        @digester = digester
      end

      def call
        digester.call query_string
      end

      private

      attr_reader :key, :params, :digester

      def query_string
        params.sort.push(key).join("&")
      end
    end

  end
end
