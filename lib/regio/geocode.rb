# frozen_string_literal: true

require 'httparty'
require 'json'

module Regio
  class Geocode
    include HTTParty
    base_uri 'https://api.regio.ee'

    COMPONENTS = [
      { name: :country, type: 'A0' },
      { name: :county, type: 'A1' },
      { name: :municipality, type: 'A2' },
      { name: :settlement, type: 'A3' },
      { name: :small_place, type: 'A4' },
      { name: :street, type: 'A5' },
      { name: :farmstead, type: 'A6' },
      { name: :house, type: 'A7' },
      { name: :apartment, type: 'A8' }
    ].freeze

    attr_accessor :options

    def initialize(options = {})
      @options = default_options.merge(options)
    end

    def results
      response.merge(
        collection: response[:data]&.map { |result| transform(result) } || []
      )
    end

    private

    def response
      JSON.parse(self.class.get('/geocode', query: options).body, symbolize_names: true)
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

    def transform(result)
      hash = default_hash_for(result)

      COMPONENTS.each do |component|
        item = result[:components].detect { |o| o[:type] == component[:type] }
        hash[component[:name]] = item.nil? ? nil : item[:name]
      end

      hash
    end

    def default_hash_for(result)
      {
        regio_id: result[:id],
        title: result[:address],
        valid: result[:is_valid],
        complete: result[:is_complete],
        zipcode: result[:postcode],
        lat: result[:geometry].last,
        lon: result[:geometry].first
      }
    end
  end
end
