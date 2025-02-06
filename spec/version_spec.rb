require 'spec_helper'

RSpec.describe Unit do
  it 'returns the correct version' do
    expect(Unit::VERSION).to eq '0.10.1'
  end
end

