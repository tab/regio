# frozen_string_literal: true

module Regio
  class Failed < StandardError
    def initialize(msg = 'Failed')
      super
    end

    def http_status_code
      400
    end
  end
end
