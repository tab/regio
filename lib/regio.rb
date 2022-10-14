# frozen_string_literal: true

require 'regio/configuration'
require 'regio/core'
require 'regio/geocode'
require 'regio/reverse_geocode'
require 'regio/errors/failed'
require 'regio/errors/forbidden'
require 'regio/errors/not_found'
require 'regio/errors/unprocessable'
require 'regio/version'

module Regio
  class Error < StandardError
  end
end
