# frozen_string_literal: true

module Regio
  class NotFound < StandardError
    def initialize(msg = 'Not found')
      super
    end

    def http_status_code
      403
    end
  end
end
