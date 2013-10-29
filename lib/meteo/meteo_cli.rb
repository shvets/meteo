require "thor"
require 'json'
require 'meteo'
require 'meteo/reporter'

class MeteoCLI < Thor
  include Reporter

  desc "quote location", "quote weather for location"
  long_desc <<-LONGDESC
    `meteo` will print weather quote for requested city.

    You can optionally specify a second parameter, which will print
    out a from message as well.

    > $ meteo quote "Plainsboro, NJ"
    > $ meteo quote "Moscow, RU" --units=metric
  LONGDESC
  option :units
  def quote(location)
    units = options[:units] ? options[:units] : "imperial"

    service = Meteo.new

    response = JSON.parse(service.quote(location, units))

    puts report(response, units).join(' ')
  end

end
