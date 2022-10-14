# frozen_string_literal: true

# NOTE: In order to track coverage simplecov needs to be the first one
if ENV.fetch('COVERAGE', false)
  require 'simplecov'

  SimpleCov.start do
    add_filter '/spec/'
    add_filter 'lib/regio/version'

    track_files 'lib/**/*.rb'
  end
end

require 'bundler/setup'
require 'regio'

Dir[('./spec/support/**/*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
end
