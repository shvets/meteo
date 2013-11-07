# -*- encoding: utf-8 -*-

require 'meteo/colors'
require 'awesome_print'

class WeatherReporter
  include Colors

  WIND_DIRECTIONS = %W(N NNE NE ENE E ESE SE SSE S SSW SW WSW W WNW NW NNW)

  def report(response, units, forecast)
    if forecast == 0
      current_weather_report response, units
    else
      forecast_report response, units, forecast
    end
  end

  def current_weather_report response, units
    if response["message"]
      puts response["message"]
    else
      sunrise = response['sys']['sunrise']
      sunset = response['sys']['sunset']
      pressure = response['main']['pressure']
      city = response['name']
      temperature = response['main']['temp']
      humidity = response['main']['humidity']
      sky = response['weather'][0]['main']
      wind = response['wind']['speed']
      azimuth = response['wind']['deg']

      direction = WIND_DIRECTIONS[((azimuth + 11.25)/22.5 % 16).to_i]

      result = %W(
        #{background}#{text}#{get_icon(sky, current_period(sunset, sunrise))}#{dashes}#{text}
        #{city} #{delimiter}#{data}
        #{text}Temperature #{data}#{temperature}#{temperature_scale(units)}
        #{text}Humidity #{data}#{humidity}%
        #{text}Wind #{data}#{wind}#{speed_unit(units)} #{direction}
        #{text}Pressure #{data}#{pressure(pressure, units)}#{pressure_unit(units)}
        #{text}Sunrise #{data}#{Time.at(sunrise).strftime('%I:%M:%S%p')}
        #{text}Sunset #{data}#{Time.at(sunset).strftime('%I:%M:%S%p')}#{stop}
      )

      puts result.join(' ')
    end
  end

  def forecast_report response, units, forecast
    city = response['city']['name']

    max_forecast = response['list'].size

    forecast = (forecast <= max_forecast) ? forecast : max_forecast

    puts "#{background}#{text}Forecast for #{city}:"

    (0..forecast-1).each do |index|
      day = response['list'][index]
      sky = day['weather'][0]['main']
      date = day['dt']
      max = day['temp']['max']
      min = day['temp']['min']
      morning = day['temp']['morn']
      evening = day['temp']['eve']
      night = day['temp']['night']
      humidity = day['humidity']
      pressure = day['pressure']

      wind = day['speed']
      azimuth = day['deg']

      direction = WIND_DIRECTIONS[((azimuth + 11.25)/22.5 % 16).to_i]

      result = %W(
        #{background}#{text}#{index+1}. #{get_icon(sky, 'none')}
        #{data}#{Time.at(date).strftime('%Y/%m/%d')}
        #{text}Temperature
        #{text}min: #{data}#{min}#{temperature_scale(units)}
        #{text}max: #{data}#{max}#{temperature_scale(units)}
        #{text}morning: #{data}#{morning}#{temperature_scale(units)}
        #{text}evening: #{data}#{evening}#{temperature_scale(units)}
        #{text}night: #{data}#{night}#{temperature_scale(units)}
        #{text}Humidity #{data}#{humidity}%
        #{text}Wind #{data}#{wind}#{speed_unit(units)} #{direction}
        #{text}Pressure #{data}#{pressure(pressure, units)}#{pressure_unit(units)}#{stop}
      )

      puts result.join(' ')
    end
  end

  def get_icon(sky, period)
    name =
    case sky
      when 'Clear'
        (period == "night") ? moon : sun

      when 'Clouds'
        clouds

      when 'Rain'
        rain

      when 'Fog'
        fog

      when 'Snow'
        snow

      when 'Thunderstorm'
        thunderstorm

      else
        (period == "night") ? moon : sun
    end
  end

  def current_period
    current_time = Time.now.to_i

    if current_time >= sunset or current_time <= sunrise
      'night'
    else
      'day'
    end
  end

  def temperature_scale units
    (units == 'metric') ? "°C" : "°F"
  end

  def speed_unit units
    (units == 'metric') ? "m/s" : "mph"
  end

  def pressure_unit units
    (units == 'metric') ? "hPa" : "inHg"
  end

  def pressure pressure, units
    (units == 'metric') ? sprintf('%.0f', pressure) : sprintf('%.2f', pressure*0.0295)
  end
end


