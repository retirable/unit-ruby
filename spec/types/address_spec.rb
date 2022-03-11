require 'spec_helper'

RSpec.describe Unit::Types::Address do
  let(:street) { '123 Main St.' }
  let(:city) { 'Brooklyn' }
  let(:state) { 'NY' }
  let(:postal_code) { '11211' }
  let(:country) { 'USA' }

  subject do
    described_class.new(
      street: street,
      city: city,
      state: state,
      postal_code: postal_code,
      country: country
    )
  end

  it 'instantiates an instance of the type' do
    expect(subject.street).to eq street
    expect(subject.city).to eq city
    expect(subject.state).to eq state
    expect(subject.postal_code).to eq postal_code
    expect(subject.country).to eq country
  end

  describe '#self.cast' do
    let(:new_street) { '55 E. 7th St.' }
    let(:new_city) { 'Boston' }
    let(:new_state) { 'MA' }
    let(:new_postal_code) { '01784' }
    let(:new_country) { 'USA' }

    it 'returns the value if it is already a Types::Address instance' do
      expect(described_class.cast(subject)).to eq subject
    end

    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'instantiates a new instance with the provided attributes' do
      instance = described_class.cast(
        {
          street: new_street,
          city: new_city,
          state: new_state,
          postal_code: new_postal_code,
          country: new_country
        }
      )

      expect(instance.street).to eq new_street
      expect(instance.city).to eq new_city
      expect(instance.state).to eq new_state
      expect(instance.postal_code).to eq new_postal_code
      expect(instance.country).to eq new_country
    end
  end

  describe '#as_json_api' do
    it 'returns a hash with the correct attributes' do
      expect(subject.as_json_api).to eq(
        {
          street: street,
          city: city,
          state: state,
          postal_code: postal_code,
          country: country
        }
      )
    end
  end
end
