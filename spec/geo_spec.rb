require File.dirname(__FILE__) + '/spec_helper'

require 'meteo/geo'

describe Geo do
  describe "#quote" do
    it "gets the quote" do
      result = subject.quote("apple.com")

      expect(result['city']).to eq("Cupertino")
      expect(result['country_code']).to eq("US")
    end
  end

end