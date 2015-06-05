require "json"

using FyberOffers::Utils

module FyberOffers
  module API

    class Response
      attr_reader :raw, :body, :code, :message, :count, :pages

      def initialize(raw)
        @raw  = raw
        @body = parse raw

        assert_is_valid

        @code    = parse_code @body[:code]
        @message = @body[:message]
        @count   = Integer(@body[:count])
        @pages   = Integer(@body[:pages])
      end

      private

      def parse(content)
        JSON.parse content, symbolize_names: true
      end

      def parse_code(string)
        string.downcase.to_sym
      end

      def assert_is_valid
        raise Error::InvalidResponse if code_is_blank?

        validate_code body[:code]
      end

      def code_is_blank?
        body.blank? || body[:code].blank?
      end

      def validate_code(fyber_code)
        status, code = detect_status(fyber_code)

        raise_error(code) if status == :error

        true
      end

      def detect_status(code)
        case code
          when "OK"                          then [:ok,    "ok"                 ]
          when "NO_CONTENT"                  then [:ok,    "no_content"         ]
          when /\AERROR_(INVALID.+)\z/       then [:error, $1.downcase          ]
          when "ERROR_INTERNAL_SERVER_ERROR" then [:error, "remote_server_error"]
          else                                    [:error, "unknown_code"       ]
        end
      end

      def raise_error(error_string)
        camelized = error_string.gsub(/(?:^|_)([a-z])/) { $1.upcase }
        raise Error.const_get(camelized)
      end
    end

  end
end
