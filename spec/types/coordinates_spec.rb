RSpec.describe Unit::Types::Coordinates do
  let(:longitude) { '40.0123' }
  let(:latitude) { '-74.0060' }

  subject do
    described_class.new(
      longitude: longitude,
      latitude: latitude
    )
  end

  it 'instantiates an instance of the type' do
    expect(subject.longitude).to eq longitude
    expect(subject.latitude).to eq latitude
  end

  describe '#self.cast' do
    let(:new_longitude) { '51.5072' }
    let(:new_latitude) { '0.1276' }

    it 'returns the value if it is already a Types::Coordinates instance' do
      expect(described_class.cast(subject)).to eq subject
    end

    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'instantiates a new instance with the provided attributes' do
      instance = described_class.cast(
        {
          longitude: new_longitude,
          latitude: new_latitude
        }
      )

      expect(instance.longitude).to eq new_longitude
      expect(instance.latitude).to eq new_latitude
    end
  end

  describe '#as_json_api' do
    it 'returns a hash with the correct attributes' do
      expect(subject.as_json_api).to eq(
        {
          longitude: longitude,
          latitude: latitude
        }
      )
    end
  end
end
