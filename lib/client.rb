require "api/hasher"
require "api/digester"
require "api/timestamper"

module FyberOffers
  MissingAttributeError = Class.new(StandardError)

  class Client
    MANDATORY_PARAMS = [ :uid, :appid, :device_id, :locale ]
    OPTIONAL_PARAMS  = [ :ip, :offer_types ]

    attr_reader :api_url, :api_key, :uid, :appid, :device_id, :ip, :locale, :offer_types

    def initialize(url:, key:, params:, **options)
      validate_params_presence params

      @api_url     = url
      @api_key     = key
      @uid         = params[:uid]
      @appid       = params[:appid]
      @device_id   = params[:device_id]
      @ip          = params[:ip]
      @locale      = params[:locale]
      @offer_types = params[:offer_types]

      @timestamper = options.fetch(:timestamper, API::Timestamper)
      @hasher      = options.fetch(:hasher, API::Hasher)
    end

    def call
      []
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

    def query_params
      query_values.push("hashkey=#{hashkey}").join("&")
    end

    def hashkey
      @hasher.new(params: query_values, key: api_key).call
    end

    def query_values
      params.map {|k,v| "#{k}=#{v}"}
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

    def timestamp
      @timestamper.call
    end

    def blank?(obj)
      obj.respond_to?(:empty?) ? !!obj.empty? : !obj
    end
  end
end
