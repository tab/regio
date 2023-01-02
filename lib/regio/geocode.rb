# frozen_string_literal: true

module Regio
  class Geocode < Core
    def results
      raise Unprocessable, response[:message] if response[:message]

      response.merge(
        collection: response[:data]&.map { |result| transform(result) } || []
      )
    end

    private

    def response
      @response ||= run('/geocode', options)
    end

    # NOTE: all options described in the documentation
    # https://api.regio.ee/documentation/#docs/geocode
    def default_options
      {
        country: 'ee',
        apikey: Configuration.api_key,
        address_format: 'long_address',
        details: 'id,address,postcode,type,components,geometry,is_valid,is_complete',
        output_format: 'json',
        limit: 25
      }
    end
  end
end
