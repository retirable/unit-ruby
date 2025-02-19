require 'spec_helper'

RSpec.describe Unit::Types::Date do
  describe '#self.cast' do
    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'casts a date value as a date' do
      expect(described_class.cast(::Date.parse('2001-02-03'))).to eq ::Date.parse('2001-02-03')
    end

    it 'casts a string value as a date' do
      expect(described_class.cast('2001-02-03')).to eq ::Date.parse('2001-02-03')
      expect(described_class.cast('3rd Feb 2001')).to eq ::Date.parse('2001-02-03')
      expect(described_class.cast('20010203')).to eq ::Date.parse('2001-02-03')
    end
  end

  describe '#self.as_json_api' do
    it 'returns nil if the value is nil' do
      expect(described_class.as_json_api(nil)).to eq nil
    end

    it 'returns the date as a string' do
      expect(described_class.as_json_api(::Date.parse('2001-02-03'))).to eq '2001-02-03'
    end
  end
end
