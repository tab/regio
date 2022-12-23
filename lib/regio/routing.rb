# frozen_string_literal: true

module Regio
  class Routing < Core
    def results
      response.tap do |response|
        raise Unprocessable, response[:message] if response[:message]
      end
    end

    private

    def response
      options[:coordinates] = options[:coordinates].map { |lnglat| lnglat.join(',') }.join(';') if options[:coordinates]

      run('/routing', options)
    end

    # NOTE: all options described in the documentation
    # https://api.regio.ee/documentation/#docs/routing_and_directions
    def default_options
      {
        apikey: Configuration.api_key,
        output_format: 'json',
        limit: 25
      }
    end
  end
end
