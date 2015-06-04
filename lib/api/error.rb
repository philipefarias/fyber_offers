module FyberOffers
  module API

    module Error
      MissingAttribute  = Class.new(StandardError)
      InvalidResponse   = Class.new(StandardError)
      InvalidPage       = Class.new(StandardError)
      InvalidAppid      = Class.new(StandardError)
      InvalidUid        = Class.new(StandardError)
      InvalidHashkey    = Class.new(StandardError)
      InvalidDeviceId   = Class.new(StandardError)
      InvalidIp         = Class.new(StandardError)
      InvalidTimestamp  = Class.new(StandardError)
      InvalidLocale     = Class.new(StandardError)
      InvalidAndroidId  = Class.new(StandardError)
      InvalidCategory   = Class.new(StandardError)
      RemoteServerError = Class.new(StandardError)
      UnknownCode       = Class.new(StandardError)
    end

  end
end
