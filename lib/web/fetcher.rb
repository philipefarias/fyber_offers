require "yaml"

module FyberOffers
  module Web

    class Fetcher
      def call
        client.call
      end

      private

      def client
        FyberOffers::API::Client.new url: api(:url),
          key: api(:key),
          params: api(:params)
      end

      def api(key)
        config[key.to_s]
      end

      def config
        @config ||= YAML.load file
      end

      def file
        File.read(File.expand_path("../../../api.yml", __FILE__))
      end
    end

  end
end
