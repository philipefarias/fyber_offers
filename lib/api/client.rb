module FyberOffers
  module API

    class Client
      MANDATORY_PARAMS = [ :uid, :appid, :device_id, :locale ]

      attr_accessor :api_url, :api_key

      def initialize(url:, key:, **options)
        @api_url     = url
        @api_key     = key

        @requester   = options.fetch(:requester,   Requester).new(base_url)
        @timestamper = options.fetch(:timestamper, Timestamper)
        @hasher      = options.fetch(:hasher,      Hasher)
      end

      def call(params)
        if params
          response = @requester.call query_params(params)
          response.body.fetch(:offers, [])
        else
          []
        end
      end

      private

      def base_url
        "#{api_url}.#{format}"
      end

      def query_params(params)
        request_params = RequestParams.new(params).delete_blanks
        request_params.assert_keys_presence(MANDATORY_PARAMS)
        request_params.assert_values_presence
        request_params[:timestamp] = timestamp
        request_params[:hashkey]   = hashkey_for request_params.to_a
        request_params
      end

      def hashkey_for(query_values)
        @hasher.new(params: query_values, key: api_key).call
      end

      def timestamp
        @timestamper.call
      end

      def format
        :json
      end
    end

  end
end
