# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'toggl_integrator/version'

Gem::Specification.new do |spec|
  spec.name          = 'toggl_integrator'
  spec.version       = TogglIntegrator::VERSION
  spec.authors       = ['rikoroku']
  spec.email         = ['rikoroku.55@gmail.com']

  spec.summary       = 'Toggl Integration With Google Calendar.'
  spec.homepage      = 'https://kogawa.work/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '~> 4.2.0'
  spec.add_dependency 'google-api-client'
  spec.add_dependency 'sqlite3', '~> 1.3.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'redcarpet', '~> 2.2'
  spec.add_development_dependency 'rubocop', '~> 0.84.0'
  spec.add_development_dependency 'yard', '~> 0.9.25'
end
