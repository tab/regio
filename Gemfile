# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gemspec

group :development, :test do
  gem 'rspec', '~> 3.13.0'

  gem 'rubocop', '~> 1.64.1'
  gem 'rubocop-performance', '~> 1.21.0'
  gem 'rubocop-rspec', '~> 2.30.0'
end

group :development do
  gem 'bundler', '~> 2.3.0'
  gem 'rake', '~> 13.0.6'
end

group :test do
  gem 'simplecov', '~> 0.22.0'
  gem 'webmock', '~> 3.23.1'
end
