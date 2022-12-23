# frozen_string_literal: true

RSpec.describe Regio::Routing do
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

    shared_examples 'respond with ok response' do
      it { expect(results).to eq(response) }
    end

    context 'when options is empty' do
      let(:options) do
        {}
      end

      before do
        regio_stub_request(:get, '/routing').to_return(regio_response('routing/error.json'))
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
        regio_stub_request(:get, '/routing').to_return(regio_response('routing/error.json'))
      end

      include_examples 'raise unprocessable error'
    end

    context 'when invalid coordinates provided' do
      let(:options) do
        {
          coordinates: [[224.649138022268, 59.14048887149], [25.853136227622, 59.00678681919]]
        }
      end

      before do
        regio_stub_request(:get, '/routing').to_return(regio_response('routing/invalid.json'))
      end

      it do
        expect { results }.to raise_error(Regio::Unprocessable, 'Invalid coordinate value')
      end
    end

    context 'when query is valid' do
      let(:response) do
        JSON.parse(File.read('./spec/fixtures/routing/ok.json'), symbolize_names: true)
      end

      let(:options) do
        {
          coordinates: [[24.649138022268, 59.14048887149], [25.853136227622, 59.00678681919]]
        }
      end

      before do
        regio_stub_request(:get, '/routing').to_return(regio_response('routing/ok.json'))
      end

      include_examples 'respond with ok response'
    end
  end
end
