# frozen_string_literal: true

module Regio
  class Forbidden < StandardError
    def initialize(msg = 'Forbidden')
      super
    end

    def http_status_code
      403
    end
  end
end
