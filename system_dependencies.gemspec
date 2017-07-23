# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'system_dependencies/version'

Gem::Specification.new do |spec|
  spec.name          = 'system_dependencies'
  spec.version       = SystemDependencies::VERSION
  spec.authors       = ['abdomazzika']
  spec.email         = ['newmazzikastyle@gmail.com']

  spec.summary       = "detect the sytem level libraries needed for gem's installation"
  spec.description   = "gathering all local gem's and send them to service which reply by the array of system libraries needed for installation"
  spec.homepage      = 'https://github.com/abdomazzika/system_dependencies'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org/'
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
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'typhoeus'
  spec.add_development_dependency 'rubocop-git'
  spec.add_development_dependency 'os'

  spec.add_runtime_dependency 'os'
  spec.add_runtime_dependency 'typhoeus'
end
