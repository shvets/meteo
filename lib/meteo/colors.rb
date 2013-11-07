# -*- encoding: utf-8 -*-

module Colors
  def sun
    "\033[33;1m\xe2\x98\x80"
  end

  def moon
    "\033[36m\xe2\x98\xbd"
  end

  def clouds
    "\033[37;1m\xe2\x98\x81"
  end

  def rain
    "\xe2\x98\x94"
  end

  def fog
    "\033[37;1m\xe2\x96\x92"
  end

  def snow
    "\033[37;1m\xe2\x9d\x84"
  end

  def thunderstorm
    "\xe2\x9a\xa1"
  end

  def background
    "\033[44m"
  end

  def dashes
    "\033[34m-"
  end

  def text
    "\033[36;1m"
  end

  def delimiter
    "\033[35m=>"
  end

  def data
    "\033[33;1m"
  end

  def stop
    "\033[0m"
  end
end