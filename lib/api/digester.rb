module FyberOffers
  module API

    class Digester
      def self.call(string)
        Digest::SHA1.hexdigest string
      end
    end

  end
end
