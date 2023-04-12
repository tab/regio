# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gemspec

group :development, :test do
  gem 'rspec', '~> 3.12.0'
  gem 'rubocop', '~> 1.50.1'
  gem 'rubocop-performance', '~> 1.16.0'
  gem 'rubocop-rspec', '~> 2.19.0'
end

group :test do
  gem 'simplecov', '~> 0.22.0'
  gem 'webmock', '~> 3.18.1'
end
