require "json"

using FyberOffers::Utils

module FyberOffers
  module API

    class Response
      OK_CODES = %w(OK NO_CONTENT)

      attr_reader :raw, :body, :code, :message, :count, :pages

      def initialize(raw)
        @raw  = raw
        @body = parse raw

        assert_is_valid

        @code    = @body[:code]
        @message = @body[:message]
        @count   = Integer(@body[:count])
        @pages   = Integer(@body[:pages])
      end

      private

      def parse(content)
        JSON.parse content, symbolize_names: true
      end

      def assert_is_valid
        raise Error::InvalidResponse if code_is_blank?

        validate_code body[:code]
      end

      def code_is_blank?
        body.blank? || body[:code].blank?
      end

      def validate_code(code)
        return true if ok? code

        error = response_errors[code]
        error ? raise(error) : raise(Error::UnknownCode)
      end

      def ok?(code)
        OK_CODES.include? code
      end

      def response_errors
        {
            "ERROR_INVALID_PAGE"          => Error::InvalidPage,
            "ERROR_INVALID_APPID"         => Error::InvalidAppid,
            "ERROR_INVALID_UID"           => Error::InvalidUid,
            "ERROR_INVALID_HASHKEY"       => Error::InvalidHashkey,
            "ERROR_INVALID_DEVICE_ID"     => Error::InvalidDeviceId,
            "ERROR_INVALID_IP"            => Error::InvalidIp,
            "ERROR_INVALID_TIMESTAMP"     => Error::InvalidTimestamp,
            "ERROR_INVALID_LOCALE"        => Error::InvalidLocale,
            "ERROR_INVALID_ANDROID_ID"    => Error::InvalidAndroidId,
            "ERROR_INVALID_CATEGORY"      => Error::InvalidCategory,
            "ERROR_INTERNAL_SERVER_ERROR" => Error::RemoteServerError
        }
      end
    end

  end
end
