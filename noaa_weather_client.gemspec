# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'noaa_weather_client/version'

Gem::Specification.new do |spec|
  spec.name          = "noaa_weather_client"
  spec.version       = NoaaWeatherClient::VERSION
  spec.authors       = ["Tyler Dooling"]
  spec.email         = ["me@tylerdooling.com"]
  spec.description   = %q{A ruby wrapper for the NOAA weather forecast and current observations API.}
  spec.summary       = %q{Provides forecasts and current observations from NOAA for geo coordinates or postal codes.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
  spec.add_dependency "savon"
end
