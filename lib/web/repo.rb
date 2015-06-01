require "securerandom"

module FyberOffers
  module Web

    class Repo
      def initialize
        @map = {}
      end

      def put(record)
        generate_id.tap do |id|
          @map[id] = record
        end
      end

      def get(id)
        @map.fetch id, []
      end

      private

      def generate_id
        SecureRandom.uuid
      end
    end

  end
end
