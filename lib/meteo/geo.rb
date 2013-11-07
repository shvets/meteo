require 'net/http'
require 'json'

class Geo
  GEO_LOCATION_SERVICE_URL = "http://freegeoip.net/json/"

  attr_reader :url

  def initialize
    @url = GEO_LOCATION_SERVICE_URL
  end

  def quote ip_address=nil
    quote_url = ip_address ? "#{url}#{ip_address}" : url

    uri = URI.parse(URI.escape(quote_url))

    JSON.parse(Net::HTTP.get(uri))
  end
end
