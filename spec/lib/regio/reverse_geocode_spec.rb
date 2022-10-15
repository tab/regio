# frozen_string_literal: true

RSpec.describe Regio::ReverseGeocode do
  include RegioHelpers

  it 'has a base_uri' do
    expect(described_class.base_uri).not_to be_nil
  end

  describe '#results' do
    subject(:results) { described_class.new(options).results }

    shared_examples 'raise unprocessable error' do
      it do
        expect { results }.to raise_error(Regio::Unprocessable, 'No API key found in request')
      end
    end

    shared_examples 'respond with an empty response' do
      let(:response) do
        {
          meta: {
            api_version: 'v1',
            dataset_version: '2022-09-15 15:28:24',
            query: 'not-a-lng,not-a-lat',
            crs_in: 4326,
            crs_out: 4326
          },
          data: [],
          collection: []
        }
      end

      it { expect(results).to eq(response) }
    end

    shared_examples 'respond with transformed response' do
      it { expect(results).to eq(response) }
    end

    context 'when options is empty' do
      let(:options) do
        {}
      end

      before do
        regio_stub_request(:get, '/revgeocode').to_return(regio_response('revgeocode/error.json'))
      end

      include_examples 'raise unprocessable error'
    end

    context 'when api key is not provided' do
      let(:options) do
        {
          apikey: 'not-a-key'
        }
      end

      before do
        regio_stub_request(:get, '/revgeocode').to_return(regio_response('revgeocode/error.json'))
      end

      include_examples 'raise unprocessable error'
    end

    context 'when coordinates are invalid' do
      let(:options) do
        {
          lat: 'not-a-lat',
          lng: 'not-a-lng'
        }
      end

      before do
        regio_stub_request(:get, '/revgeocode').to_return(regio_response('revgeocode/empty.json'))
      end

      include_examples 'respond with an empty response'
    end

    context 'when query is valid' do
      before do
        regio_stub_request(:get, '/revgeocode').to_return(regio_response("revgeocode/#{country}/ok.json"))
      end

      let(:response) do
        JSON.parse(File.read("./spec/fixtures/revgeocode/#{country}/transformed.json"), symbolize_names: true)
      end

      context 'when EE' do
        let(:country) { 'ee' }
        let(:options) do
          {
            lat: 59.4276340999273,
            lng: 24.7790924770962
          }
        end

        include_examples 'respond with transformed response'
      end
    end
  end
end
