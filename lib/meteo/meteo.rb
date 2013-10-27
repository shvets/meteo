require 'net/http'

class Meteo
  OPEN_WEATHER_MAP_SERVICE_URL = 'http://api.openweathermap.org/data/2.5/weather'

  attr_reader :url

  def initialize
    @url = OPEN_WEATHER_MAP_SERVICE_URL
  end

  def quote location, units
    quote_url = "#{url}?q=#{location}%20nj&units=#{units}"

    uri = URI.parse(URI.escape(quote_url))

    Net::HTTP.get(uri)
  end
end