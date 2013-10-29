# -*- encoding: utf-8 -*-

module Reporter
  def report(response, units)
    sunrise = response['sys']['sunrise']
    sunset = response['sys']['sunset']

    pressure = response['main']['pressure']

    city = response['name']
    temperature = response['main']['temp']
    humidity = response['main']['humidity']

    sky = response['weather'][0]['main']
    wind = response['wind']['speed']

    current_time = Time.now.to_i

    if current_time >= sunset or current_time <= sunrise
      period = 'night'
    else
      period = 'day'
    end

    case units
      when 'metric'
        scale = "°C"
        speed_unit = "m/s"
        pressure_unit = "hPa"
        pressure = sprintf('%.0f', pressure)
      when 'imperial'
        scale = "°F"
        speed_unit = "mph"
        pressure_unit = "inHg"
        pressure = sprintf('%.2f', pressure*0.0295)
      else
        # type code here
    end

    icon = self.send(weather(sky, period))

    background = "\033[44m"
    dashes = "\033[34m-"
    text = "\033[36;1m"
    delimiter = "\033[35m=>"
    data = "\033[33;1m"
    stop = "\033[0m"

    %W(
      #{background}#{text}#{icon}
      #{city} #{delimiter}#{data}
      #{text}Temperature #{data}#{temperature}#{scale}
      #{text}Humidity #{data}#{humidity}%
      #{text}Wind #{data}#{wind}#{speed_unit}
      #{text}Pressure #{data}#{pressure} #{pressure_unit}
      #{text}Sunrise #{data}#{Time.at(sunrise).strftime('%I:%M:%S%p')}
      #{text}Sunset #{data}#{Time.at(sunset).strftime('%I:%M:%S%p')}#{stop}
    )
  end

  def weather sky, period
    case sky
      when 'Clear'
        (period == "night") ? 'moon' : 'sun'

      when 'Clouds'
        "clouds"

      when 'Rain'
        "rain"

      when 'Fog'
        "fog"
      else
        (period == "night") ? 'moon' : 'sun'
    end
  end

  #def colorize(text, color_code)
  #  "\e[#{color_code}#{text}\e[0m"
  #end

  def sun
    "\033[33;1m\xe2\x98\x80"
  end

  def moon
    "\033[36m\xe2\x98\xbd"
  end

  def clouds
    "\033[37;1m\xe2\x98\x81"
  end
end
