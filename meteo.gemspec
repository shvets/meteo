# -*- encoding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/lib/meteo/version')

Gem::Specification.new do |spec|
    spec.name          = "meteo"
    spec.summary       = %q{Provides command line access to OpenWeatherMap service.}
    spec.description   = %q{Provides command line access to OpenWeatherMap service.}
    spec.email         = "alexander.shvets@gmail.com"
    spec.authors       = ["Alexander Shvets"]
    spec.homepage      = "http://github.com/shvets/meteo"
    spec.executables   = ["meteo"]

    spec.files         = `git ls-files`.split($\)
    spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
    spec.require_paths = ["lib"]
    spec.version       = Meteo::VERSION
    spec.license       = "MIT"

    
  spec.add_runtime_dependency "thor", [">= 0"]
  spec.add_development_dependency "gemspec_deps_gen", [">= 0"]
  spec.add_development_dependency "gemcutter", [">= 0"]

end

