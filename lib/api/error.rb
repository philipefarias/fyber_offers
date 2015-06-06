module FyberOffers
  module API
    Error  = Class.new(StandardError)

    MissingAttribute  = Class.new(Error)
    InvalidResponse   = Class.new(Error)
    InvalidPage       = Class.new(Error)
    InvalidAppid      = Class.new(Error)
    InvalidUid        = Class.new(Error)
    InvalidHashkey    = Class.new(Error)
    InvalidDeviceId   = Class.new(Error)
    InvalidIp         = Class.new(Error)
    InvalidTimestamp  = Class.new(Error)
    InvalidLocale     = Class.new(Error)
    InvalidAndroidId  = Class.new(Error)
    InvalidCategory   = Class.new(Error)
    RemoteServerError = Class.new(Error)
    UnknownCode       = Class.new(Error)
  end
end
