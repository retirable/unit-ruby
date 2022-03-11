require 'spec_helper'

RSpec.describe Unit::Types::Phone do
  let(:country_code) { '1' }
  let(:number) { '9175601738' }

  subject do
    described_class.new(
      country_code: country_code,
      number: number
    )
  end

  it 'instantiates an instance of the type' do
    expect(subject.country_code).to eq country_code
    expect(subject.number).to eq number
  end

  describe '#self.cast' do
    let(:new_country_code) { '44' }
    let(:new_number) { '7989273847' }

    it 'returns the value if it is already a Types::Phone instance' do
      expect(described_class.cast(subject)).to eq subject
    end

    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'instantiates a new instance with the provided attributes' do
      instance = described_class.cast(
        {
          country_code: new_country_code,
          number: new_number
        }
      )

      expect(instance.country_code).to eq new_country_code
      expect(instance.number).to eq new_number
    end
  end

  describe '#as_json_api' do
    it 'returns a hash with the correct attributes' do
      expect(subject.as_json_api).to eq(
        {
          country_code: country_code,
          number: number
        }
      )
    end
  end
end
