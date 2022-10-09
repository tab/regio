# frozen_string_literal: true

RSpec.describe Regio::Configuration do
  it 'has not a default api_key' do
    expect(described_class.api_key).to be_nil
  end
end
