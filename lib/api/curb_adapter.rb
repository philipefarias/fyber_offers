require "curb"

module FyberOffers
  module API

    class CurbAdapter
      attr_reader :conn

      def initialize(curb_class: Curl::Easy)
        @conn = curb_class.new
        @conn.encoding = "gzip, deflate"
      end

      def get(url)
        conn.url = url
        conn.perform
        conn.body_str
      end
    end

  end
end