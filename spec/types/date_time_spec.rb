require 'spec_helper'

RSpec.describe Unit::Types::DateTime do
  describe '#self.cast' do
    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'casts a string value as a strftime' do
      expect(described_class.cast('2001-02-03T04:05:06+07:00')).to eq '2001-02-03T04:05:06+07:00'
      expect(described_class.cast('20010203T040506+0700')).to eq '2001-02-03T04:05:06+07:00'
      expect(described_class.cast('3rd Feb 2001 04:05:06 AM')).to eq '2001-02-03T04:05:06+00:00'
    end
  end
end
