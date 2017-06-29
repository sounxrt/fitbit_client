# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fitbit-client/version'

Gem::Specification.new do |spec|
  spec.name          = 'fitbit-client'
  spec.version       = FitbitClient::VERSION
  spec.authors       = ['Michel Ocon']
  spec.email         = ['soun.xrt@gmail.com']
  spec.summary       = 'Client library which connects to the Fibit API using OAuth2'
  spec.description   = 'Client library which connects to the Fibit API using OAuth2.'
  spec.homepage      = 'https://github.com/sounxrt/fitbit-client'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'

  spec.add_dependency('oauth2', '~> 1.4.0')
end
