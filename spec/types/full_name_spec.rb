RSpec.describe Unit::Types::FullName do
  let(:first) { 'Roberto' }
  let(:last) { 'Endo' }

  subject do
    described_class.new(
      first: first,
      last: last
    )
  end

  it 'instantiates an instance of the type' do
    expect(subject.first).to eq first
    expect(subject.last).to eq last
  end

  describe '#self.cast' do
    let(:new_first) { 'Tyler' }
    let(:new_last) { 'Fan' }

    it 'returns the value if it is already a Types::FullName instance' do
      expect(described_class.cast(subject)).to eq subject
    end

    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'instantiates a new instance with the provided attributes' do
      instance = described_class.cast(
        {
          first: new_first,
          last: new_last
        }
      )

      expect(instance.first).to eq new_first
      expect(instance.last).to eq new_last
    end
  end

  describe '#as_json_api' do
    it 'returns a hash with the correct attributes' do
      expect(subject.as_json_api).to eq(
        {
          first: first,
          last: last
        }
      )
    end
  end
end
