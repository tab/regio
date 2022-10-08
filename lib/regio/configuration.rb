# frozen_string_literal: true

module Regio
  class Configuration
    def self.api_key
      ENV.fetch('REGIO_API_KEY', nil)
    end
  end
end
