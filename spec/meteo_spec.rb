# translate_spec.rb

require File.dirname(__FILE__) + '/spec_helper'

require 'meteo'
require 'json'
require 'awesome_print'

describe Meteo do
  describe "#quote" do
    it "gets the quote" do
      result = JSON.parse(subject.quote("plainsboro, nj", "imperial"))

      ap result

      expect(result['sys']['country']).to eq("United States of America")
    end
  end

  #it "should raise an error if one of parameters is missing" do
  #  expect { subject.meteo(nil, :ru) }.to raise_error
  #
  #  expect { subject.meteo(:en, nil) }.to raise_error
  #
  #  expect { subject.meteo(:en, :ru, nil) }.to raise_error
  #end
  #
  #it "should meteo test string from one language to another" do
  #  r = subject.meteo(:en, :ru, "hello world!")
  #  puts r
  #  r.size.should be > 0
  #end

end
