require File.dirname(__FILE__) + '/spec_helper'

require 'meteo/weather_reporter'

describe WeatherReporter do
  it 'has expected meteo status instance methods' do
    %w[fog rain moon sun clouds thunderstorm].each do |status|
      subject.methods.should include(status.to_sym)
    end
  end
end