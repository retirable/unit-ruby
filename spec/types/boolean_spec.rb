RSpec.describe Unit::Types::Boolean do
  describe '#self.cast' do
    it 'casts nil if the value is nil' do
      expect(described_class.cast(nil)).to be nil
    end

    it 'casts a string true or false value as a boolean' do
      expect(described_class.cast('true')).to be true
      expect(described_class.cast('false')).to be false
    end

    it 'casts a string 0 or 1 value as a boolean' do
      expect(described_class.cast('1')).to be true
      expect(described_class.cast('0')).to be false
    end

    it 'casts an integer 0 or 1 value as a boolean' do
      expect(described_class.cast(1)).to be true
      expect(described_class.cast(0)).to be false
    end

    it 'casts a true or false value as a boolean' do
      expect(described_class.cast(true)).to be true
      expect(described_class.cast(false)).to be false
    end
  end
end
