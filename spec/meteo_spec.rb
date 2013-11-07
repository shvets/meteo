require File.dirname(__FILE__) + '/spec_helper'

require 'meteo/meteo'

describe Meteo do
  describe "#quote" do
    it "gets the quote" do
      result = subject.quote("plainsboro, nj", "imperial")

      expect(result['sys']['country']).to eq("United States of America")
    end
  end

end
