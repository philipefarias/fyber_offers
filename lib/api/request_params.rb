using FyberOffers::Utils

module FyberOffers
  module API

    class RequestParams
      def initialize(params = {})
        @params = params.symbolize_keys
      end

      def to_h
        params
      end

      def to_a
        params.map { |k,v| "#{k}=#{v}" }
      end

      def to_s
        to_a.join("&")
      end

      def [](k)
        params[k]
      end

      def []=(k,v)
        params[k.to_sym] = v
      end

      def assert_keys_presence(*keys)
        missing = keys.flatten - params.keys
        raise MissingAttribute, "#{missing.first} is missing" unless missing.empty?
        true
      end

      def assert_values_presence
        missing = blank_params.keys
        raise MissingAttribute, "#{missing.first} cannot be blank" unless missing.empty?
        true
      end

      def delete_blanks
        params.except!(*blank_params.keys)
        self
      end

      private

      attr_accessor :params

      def blank_params
        params.select { |_,v| v.blank? }
      end
    end

  end
end
