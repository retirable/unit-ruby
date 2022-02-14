RSpec.describe Unit::Types::Float do
  describe '#self.cast' do
    it 'casts a string value as a float' do
      expect(described_class.cast('1')).to eq 1.0
    end

    it 'casts an integer value as a float' do
      expect(described_class.cast(2)).to eq 2.0
    end

    it 'casts a float value as a float' do
      expect(described_class.cast(2.12)).to eq 2.12
    end
  end
end
