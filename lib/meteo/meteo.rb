require 'net/http'
require 'json'

class Meteo
  OPEN_WEATHER_MAP_SERVICE_URL = 'http://api.openweathermap.org/data/2.5'

  attr_reader :url

  def initialize(forecast=false)
    if forecast
      @url = "#{OPEN_WEATHER_MAP_SERVICE_URL}/forecast/daily"
    else
      @url = "#{OPEN_WEATHER_MAP_SERVICE_URL}/weather"
    end
  end

  def quote location, units
    quote_url = "#{url}?q=#{location}&units=#{units}"

    uri = URI.parse(URI.escape(quote_url))

    JSON.parse(Net::HTTP.get(uri))
  end
end