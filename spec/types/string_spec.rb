RSpec.describe Unit::Types::String do
  describe '#self.cast' do
    it 'casts a string value as a string' do
      expect(described_class.cast('hello, world')).to eq 'hello, world'
    end

    it 'casts an integer value as a string' do
      expect(described_class.cast(1)).to eq '1'
    end
  end
end
