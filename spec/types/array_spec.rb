require 'spec_helper'

RSpec.describe Unit::Types::Array do
  let(:items) { %i[foo bar] }

  subject do
    described_class.new(items)
  end

  it 'instantiates an instance of the type' do
    expect(subject.items).to eq items
  end

  describe '#self.cast' do
    let(:new_items) { %i[bim bam] }

    it 'returns the value if it is already a Types::Hash instance' do
      expect(described_class.cast(subject)).to eq subject
    end

    it 'instantiates a new instance with the provided attributes' do
      instance = described_class.cast(new_items)

      expect(instance.items).to eq(new_items)
    end
  end

  describe '#as_json_api' do
    it 'returns a hash with the correct attributes' do
      expect(subject.as_json_api).to eq(items)
    end
  end
end
