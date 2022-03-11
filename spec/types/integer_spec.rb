require 'spec_helper'

RSpec.describe Unit::Types::Integer do
  describe '#self.cast' do
    it 'casts a string value as an integer' do
      expect(described_class.cast('1')).to eq 1
    end

    it 'casts an integer value as an integer' do
      expect(described_class.cast(2)).to eq 2
    end
  end
end
