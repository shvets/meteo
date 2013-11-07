require "thor"
require 'meteo/meteo'
require 'meteo/geo'
require 'meteo/weather_reporter'

class MeteoCLI < Thor

  desc "quote location", "quote weather for location"
  long_desc <<-LONGDESC
    `meteo` will print weather quote for requested city.

    You can optionally specify a second parameter, which will print
    out a from message as well.

    > $ meteo Plainsboro, NJ
    > $ meteo Moscow, RU --units=metric
    > $ meteo # get weather for current location based on IP address
  LONGDESC
  option :units, :aliases => "-u"
  option :forecast
  def quote(location)
    location = (location.nil? or location.strip.size == 0) ? Geo.new.quote : location

    units = options[:units] ? options[:units] : "imperial"
    forecast = options[:forecast] ? options[:forecast].to_i : 0

    service = Meteo.new(forecast > 0)

    response = service.quote(location, units)

    reporter = WeatherReporter.new

    reporter.report(response, units, forecast)
  end

end
