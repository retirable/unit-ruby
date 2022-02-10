RSpec.describe Unit::Types::Date do
  describe '#self.cast' do
    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'casts a string value as a strftime' do
      expect(described_class.cast('2001-02-03')).to eq '2001-02-03'
      expect(described_class.cast('3rd Feb 2001')).to eq '2001-02-03'
      expect(described_class.cast('20010203')).to eq '2001-02-03'
    end
  end
end
