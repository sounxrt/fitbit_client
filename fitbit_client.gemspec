# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fitbit_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'fitbit_client'
  spec.version       = FitbitClient::VERSION
  spec.authors       = ['Michel Ocon']
  spec.email         = ['soun.xrt@gmail.com']
  spec.summary       = 'Connects to Fibit API using OAuth2'
  spec.description   = 'Client library which connects to the Fibit API using OAuth2 protocol.'
  spec.homepage      = 'https://github.com/sounxrt/fitbit_client'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '~> 2.3'

  spec.add_development_dependency 'pry', '~> 0'
  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 1.0', '>= 1.0.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'simplecov', '~> 0.13.0'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 2.3'

  spec.add_dependency('oauth2', '~> 1.4', '>= 1.4.0')
end
