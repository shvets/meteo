# meteo_spec.rb

require File.dirname(__FILE__) + '/spec_helper'

require 'meteo'
require 'json'
#require 'awesome_print'

describe Meteo do
  describe "#quote" do
    it "gets the quote" do
      result = JSON.parse(subject.quote("plainsboro, nj", "imperial"))

      expect(result['sys']['country']).to eq("United States of America")
    end
  end

end
