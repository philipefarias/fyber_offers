require_relative "api/hasher"
require_relative "api/digester"
require_relative "api/requester"
require_relative "api/timestamper"

module FyberOffers
  MissingAttributeError = Class.new(StandardError)

  class Client
    MANDATORY_PARAMS = [ :uid, :appid, :device_id, :locale ]
    OPTIONAL_PARAMS  = [ :ip, :offer_types ]

    attr_reader :api_url, :api_key, :uid, :appid, :device_id, :ip, :locale, :offer_types

    def initialize(url:, key:, params:, **options)
      symbolize_keys params
      validate_params_presence params

      @api_url     = url
      @api_key     = key
      @uid         = params[:uid]
      @appid       = params[:appid]
      @device_id   = params[:device_id]
      @ip          = params[:ip]
      @locale      = params[:locale]
      @offer_types = params[:offer_types]

      @requester   = options.fetch(:requester,   API::Requester)
      @timestamper = options.fetch(:timestamper, API::Timestamper)
      @hasher      = options.fetch(:hasher,      API::Hasher)
    end

    def call
      response = @requester.new(url).call
      response.fetch("offers", [])
    end

    def url
      "#{api_url}.#{format}?#{query_params}"
    end

    private

    def validate_params_presence(params)
      missing = MANDATORY_PARAMS - params.keys
      raise MissingAttributeError, "#{missing.first} is missing" unless missing.empty?

      missing = params.select { |_,v| blank?(v) }.keys
      raise MissingAttributeError, "#{missing.first} cannot be blank" unless missing.empty?

      true
    end

    def symbolize_keys(hash)
      hash.keys.each do |key|
        hash[(key.to_sym rescue key) || key] = hash.delete(key)
      end
    end

    def query_params
      query_values.push("hashkey=#{hashkey}").join("&")
    end

    def hashkey
      @hasher.new(params: query_values, key: api_key).call
    end

    def query_values
      timestamp(params).map {|k,v| "#{k}=#{v}"}
    end

    def params
      (MANDATORY_PARAMS + OPTIONAL_PARAMS).inject({}) do |attrs, name|
        value = send name
        attrs[name] = value unless blank?(value)
        attrs
      end
    end

    def format
      :json
    end

    def timestamp(hash)
      hash.tap { |h| h[:timestamp] = @timestamper.call }
    end

    def blank?(obj)
      obj.respond_to?(:empty?) ? !!obj.empty? : !obj
    end
  end
end
