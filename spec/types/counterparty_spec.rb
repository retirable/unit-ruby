require 'spec_helper'

RSpec.describe Unit::Types::Counterparty do
  subject do
    described_class.new(
      name: 'Jane Doe',
      routing_number: '812345678',
      account_number: '12345569',
      account_type: 'Checking'
    )
  end

  it 'instantiates an instance of the type' do
    expect(subject.name).to eq 'Jane Doe'
    expect(subject.routing_number).to eq '812345678'
    expect(subject.account_number).to eq '12345569'
    expect(subject.account_type).to eq 'Checking'
  end

  describe '#self.cast' do
    it 'returns the value if it is already a Types::Address instance' do
      expect(described_class.cast(subject)).to eq subject
    end

    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'instantiates a new instance with the provided attributes' do
      instance = described_class.cast(
        {
          name: 'Jane Doe',
          routing_number: '812345678',
          account_number: '12345569',
          account_type: 'Checking'
        }
      )

      expect(subject).to be_a described_class
      expect(subject.name).to eq 'Jane Doe'
      expect(subject.routing_number).to eq '812345678'
      expect(subject.account_number).to eq '12345569'
      expect(subject.account_type).to eq 'Checking'
    end
  end

  describe '#as_json_api' do
    it 'returns a hash with the correct attributes' do
      expect(subject.as_json_api).to eq(
        {
          name: 'Jane Doe',
          routing_number: '812345678',
          account_number: '12345569',
          account_type: 'Checking'
        }
      )
    end
  end
end
