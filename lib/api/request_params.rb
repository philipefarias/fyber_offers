using FyberOffers::Utils

module FyberOffers
  module API

    class RequestParams
      MANDATORY_PARAMS = [ :uid, :appid, :device_id, :locale ]
      OPTIONAL_PARAMS  = [ :ip, :offer_types ]

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
        raise Error::MissingAttribute, "#{missing.first} is missing" unless missing.empty?
        true
      end

      def assert_values_presence
        missing = blank_params.keys
        raise Error::MissingAttribute, "#{missing.first} cannot be blank" unless missing.empty?
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
