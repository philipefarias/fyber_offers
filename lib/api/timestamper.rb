module FyberOffers
  module API

    class Timestamper
      def self.call
        Time.now.to_i
      end
    end

  end
end
