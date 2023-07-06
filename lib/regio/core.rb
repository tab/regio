# frozen_string_literal: true

require 'httparty'
require 'json'

module Regio
  class Core
    include HTTParty
    base_uri 'https://api.regio.ee'

    attr_accessor :options

    def initialize(options = {})
      @options = default_options.merge(options)
    end

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

    def run(path, params = {})
      JSON.parse(self.class.get(path, query: params).body, symbolize_names: true)
    end

    private

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
        ads_adr_id: result[:ads_adr_id],
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
