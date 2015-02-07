# stack = Faraday::Builder.new do |builder|
#   builder.use Faraday::HttpCache, store: Rails.cache
#   builder.response :logger
#   builder.use Ohanakapa::Response::RaiseError
#   builder.adapter Faraday.default_adapter
# end

Ohanakapa.configure do |config|
  config.api_token = ENV["OHANA_API_TOKEN"]
  config.api_endpoint = ENV["OHANA_API_ENDPOINT"]
  #config.middleware = stack
end

