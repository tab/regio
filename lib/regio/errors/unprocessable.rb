# frozen_string_literal: true

module Regio
  class Unprocessable < StandardError
    def initialize(msg = 'Unprocessable')
      super
    end

    def http_status_code
      422
    end
  end
end
