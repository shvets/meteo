require 'spec_helper'
require File.expand_path('../../lib/meteo/reporter', __FILE__)

describe Reporter do
  it 'has expected meteo status instance methods' do
    %w[fog rain moon sun clouds].each do |status|
      subject.instance_methods.should include(status.to_sym)
    end
  end
end