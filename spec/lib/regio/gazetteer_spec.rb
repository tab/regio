# frozen_string_literal: true

RSpec.describe Regio::Gazetteer do
  include RegioHelpers

  it 'has a base_uri' do
    expect(described_class.base_uri).not_to be_nil
  end

  describe '#results' do
    subject(:results) { described_class.new(options).results }

    shared_examples 'raise unprocessable error no api key found' do
      it do
        expect { results }.to raise_error(Regio::Unprocessable, 'No API key found in request')
      end
    end

    shared_examples 'raise unprocessable error invalid credentials' do
      it do
        expect { results }.to raise_error(Regio::Unprocessable, 'Invalid authentication credentials')
      end
    end

    shared_examples 'respond with an empty response' do
      let(:response) do
        {
          meta: {
            api_version: 'v1',
            dataset_version: '2022-11-16',
            query: 'address_children',
            id: 123_456_789,
            address_types: [],
            address_count: 0
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
        regio_stub_request(:get, '/gazetteer').to_return(regio_response('gazetteer/error-no-apikey.json'))
      end

      include_examples 'raise unprocessable error no api key found'
    end

    context 'when api key is not provided' do
      let(:options) do
        {
          apikey: 'not-a-key'
        }
      end

      before do
        regio_stub_request(:get, '/gazetteer').to_return(regio_response('gazetteer/error-invalid-apikey.json'))
      end

      include_examples 'raise unprocessable error invalid credentials'
    end

    context 'when address is invalid' do
      let(:options) do
        {
          address: '123456789',
          query: 'address_children'
        }
      end

      before do
        regio_stub_request(:get, '/gazetteer').to_return(regio_response('gazetteer/empty.json'))
      end

      include_examples 'respond with an empty response'
    end

    context 'when query is valid' do
      let(:options) do
        {
          id: '16004253',
          query: 'address_details'
        }
      end

      let(:response) do
        JSON.parse(File.read("./spec/fixtures/gazetteer/#{options[:id]}/transformed.json"), symbolize_names: true)
      end

      before do
        regio_stub_request(:get, '/gazetteer').to_return(regio_response("gazetteer/#{options[:id]}/ok.json"))
      end

      include_examples 'respond with transformed response'
    end
  end
end
