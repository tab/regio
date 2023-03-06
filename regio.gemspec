# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'regio/version'

Gem::Specification.new do |spec|
  spec.name          = 'regio'
  spec.version       = Regio::VERSION
  spec.authors       = ['tab']
  spec.email         = ['tab@users.noreply.github.com']

  spec.summary       = 'Regio geocoding API'
  spec.description   = 'Regio geocoding API lets you search for addresses from complete Estonian address database'
  spec.homepage      = 'https://github.com/tab/regio'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.6'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = spec.homepage
    spec.metadata['changelog_uri'] = 'https://github.com/tab/regio/blob/master/CHANGELOG.md'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
          'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|rspec|rubocop|github)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '>= 0.20', '< 0.22'

  spec.add_development_dependency 'bundler', '~> 2.3.0'
  spec.add_development_dependency 'rake', '~> 13.0.6'
  spec.add_development_dependency 'rspec', '~> 3.12.0'
  spec.add_development_dependency 'rubocop', '~> 1.36'
  spec.add_development_dependency 'rubocop-performance', '~> 1.15'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.19.0'
  spec.add_development_dependency 'simplecov', '~> 0.22.0'
  spec.add_development_dependency 'webmock', '~> 3.18.1'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
