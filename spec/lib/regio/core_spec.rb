# frozen_string_literal: true

RSpec.describe Regio::Core do
  it 'has a base_uri' do
    expect(described_class.base_uri).not_to be_nil
  end

  it 'has components' do
    expect(described_class::COMPONENTS).not_to be_nil
  end
end
