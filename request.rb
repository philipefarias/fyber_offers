require 'yaml'
require 'digest/sha1'
require 'net/http'
require 'uri'

# http://api.sponsorpay.com/feed/v1/offers.json?appid=[APP_ID]&uid=[USER_ID]&ip=[IP_ADDRESS]&locale=[LOCALE]&device_id=[DEVICE_ID]&ps_time=[TIMESTAMP]&pub0=[CUSTOM]&timestamp=[UNIX_TIMESTAMP]&offer_types=[OFFER_TYPES]&apple_idfa=[IDFA]&apple_idfa_tracking_enabled=[IDFA ENABLED]&hashkey=[HASHKEY]

## Params
#  format                      # The response format (lower case), selected by the extension after offers. (json or xml)
#  appid                       # The Fyber Application ID for your application. (157)
#  uid                         # The unique User ID, as used internally in your application. (player1)
#  ip_address                  # The IP address of the device of your user. If the parameter is not given, the IP address of the request will be used. (212.45.111.17)
#  locale                      # The locale used for the offer descriptions. (de)
#  os_version                  # Current version of the users Operating System, retrieve via UIDevice systemVersion for iOS (6.0)
#  device_id
#  ps_time                     # The creation date of the users account in your game in Unix Timestamp format. (1312211903)
#  pub0                        # Custom parameters. (campaign2)
#  page                        # The page of the response set that you are requesting. (1)
#  timestamp                   # unix timestamp - The time the request is being sent by the device (1312471066)
#  offer_types                 # Filter the results based on type of offer. (112)
#  apple_idfa                  # Apple ID for Advertising. (2E7CE4B3-F68A-44D9-A923-F4E48D92B31E)
#  apple_idfa_tracking_enabled # Is user tracking via Apple ID for Advertising enabled by the user? (true or false)
#  hashkey                     # The hash that signs the whole request. (eff26c67f527e6817bf6 935c75f8cc5cc5cffac2)

API_CONF = YAML.load File.read("api.yml")

def params
  partial_params = api_params
  partial_params[:ps_time] = timestamp
  partial_params[:timestamp] = timestamp

  params = partial_params.map {|k,v| "#{k}=#{v}"}
  with_hashkey(params, api_key).join("&")
end

def with_hashkey(params, api_key)
  hash = digest params.dup.sort.push(api_key).join("&")
  params << "hashkey=#{hash}"
end

def api_key
  API_CONF["key"]
end

def api_url
  API_CONF["url"]
end

def api_params
  API_CONF["params"]
end

def timestamp
  Time.now.to_i
end

def digest(string)
  Digest::SHA1.hexdigest string
end

def url
  api_url + "?" + params
end

def request(url)
  puts "\nRequesting URI: #{url}\n"

  Net::HTTP.get_print URI(url)
end

# Doing the thing
request url
puts
