# frozen_string_literal: true

RSpec.describe Regio::Geocode do
  include RegioHelpers

  it 'has a base_uri' do
    expect(described_class.base_uri).not_to be_nil
  end

  describe '#results' do
    subject(:results) { described_class.new(options).results }

    shared_examples 'respond with an error' do
      let(:error) do
        {
          message: 'No API key found in request',
          collection: []
        }
      end

      it { expect(results).to eq(error) }
    end

    shared_examples 'respond with an empty response' do
      let(:response) do
        {
          meta: {
            api_version: 'v1',
            dataset_version: '2021-05-16',
            query: 'qqqqqq',
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
        regio_stub_request(:get, '/geocode').to_return(regio_response('geocode/error.json'))
      end

      include_examples 'respond with an error'
    end

    context 'when api key is not provided' do
      let(:options) do
        {
          apikey: 'not-a-key'
        }
      end

      before do
        regio_stub_request(:get, '/geocode').to_return(regio_response('geocode/error.json'))
      end

      include_examples 'respond with an error'
    end

    context 'when address is invalid' do
      let(:options) do
        {
          address: 'qqqqqq',
          country: 'ee'
        }
      end

      before do
        regio_stub_request(:get, '/geocode').to_return(regio_response('geocode/empty.json'))
      end

      include_examples 'respond with an empty response'
    end

    context 'when query is valid' do
      before do
        regio_stub_request(:get, '/geocode').to_return(regio_response("geocode/#{options[:country]}/ok.json"))
      end

      let(:response) do
        JSON.parse(File.read("./spec/fixtures/geocode/#{options[:country]}/transformed.json"), symbolize_names: true)
      end

      context 'when EE' do
        let(:options) do
          {
            address: 'tallinn parnu mnt 69',
            country: 'ee'
          }
        end

        include_examples 'respond with transformed response'
      end

      context 'when LT' do
        let(:options) do
          {
            address: 'vivulskio gatve 35',
            country: 'lt'
          }
        end

        include_examples 'respond with transformed response'
      end

      context 'when LV' do
        let(:options) do
          {
            address: 'jeci 35',
            country: 'lv'
          }
        end

        include_examples 'respond with transformed response'
      end

      context 'when FI' do
        let(:options) do
          {
            address: 'helsinki töölönlahdenkatu 4',
            country: 'fi'
          }
        end

        include_examples 'respond with transformed response'
      end
    end
  end
end
