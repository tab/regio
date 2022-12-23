# frozen_string_literal: true

module Regio
  class Gazetteer < Core
    def results
      raise Unprocessable, response[:message] if response[:message]

      response.merge(
        collection: response[:data]&.map { |result| transform(result) } || []
      )
    end

    private

    def response
      @response ||= run('/gazetteer', options)
    end

    # NOTE: all options described in the documentation
    # https://api.regio.ee/documentation/#docs/gazetteer
    def default_options
      {
        apikey: Configuration.api_key,
        address_format: 'long_address',
        output_format: 'json'
      }
    end
  end
end
