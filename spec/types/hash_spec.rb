require 'spec_helper'

RSpec.describe Unit::Types::Hash do
  subject do
    described_class.new(
      {
        foo: 'bar',
        bar: 'baz'
      }
    )
  end

  it 'instantiates an instance of the type' do
    expect(subject.items).to eq(
      {
        foo: 'bar',
        bar: 'baz'
      }
    )
  end

  describe '#self.cast' do
    it 'returns the value if it is already a Types::Hash instance' do
      expect(described_class.cast(subject)).to eq subject
    end

    it 'instantiates a new instance with the provided attributes' do
      instance = described_class.cast(
        {
          bop: 'boo',
          bim: 'bam'
        }
      )

      expect(instance.items).to eq(
        {
          bop: 'boo',
          bim: 'bam'
        }
      )
    end
  end

  describe '#as_json_api' do
    it 'returns a hash with the correct attributes' do
      expect(subject.as_json_api).to eq(
        {
          foo: 'bar',
          bar: 'baz'
        }
      )
    end
  end
end
