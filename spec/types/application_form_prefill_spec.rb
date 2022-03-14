require 'spec_helper'

RSpec.describe Unit::Types::ApplicationFormPrefill do
  let(:application_type) { 'individual' }
  let(:full_name) { Unit::Types::FullName.new(first: 'Test', last: 'User') }
  let(:ssn) { '7288378173' }
  let(:passport) { '999273917' }
  let(:nationality) { 'U.S' }
  let(:date_of_birth) { '1960-01-01' }
  let(:email) { 'user@example.com' }
  let(:address) do
    Unit::Types::Address.new(
      street: '123 Main St.',
      city: 'Brooklyn',
      state: 'NY',
      postal_code: '11211',
      country: 'U.S'
    )
  end
  let(:phone) { Unit::Types::Phone.new(country_code: '1', number: '9178273647') }

  subject do
    described_class.new(
      application_type: application_type,
      full_name: full_name,
      ssn: ssn,
      passport: passport,
      nationality: nationality,
      date_of_birth: date_of_birth,
      email: email,
      address: address,
      phone: phone
    )
  end

  it 'instantiates an instance of the type' do
    expect(subject.application_type).to eq application_type
    expect(subject.full_name).to eq full_name
    expect(subject.ssn).to eq ssn
    expect(subject.passport).to eq passport
    expect(subject.nationality).to eq nationality
    expect(subject.date_of_birth).to eq date_of_birth
    expect(subject.email).to eq email
    expect(subject.address).to eq address
    expect(subject.phone).to eq phone
  end

  describe '#self.cast' do
    let(:new_application_type) { 'business' }
    let(:new_full_name) { Unit::Types::FullName.new(first: 'Sample', last: 'Person') }
    let(:new_ssn) { '828361683' }
    let(:new_passport) { '283817489' }
    let(:new_nationality) { 'U.K' }
    let(:new_date_of_birth) { '1955-09-15' }
    let(:new_email) { 'sample.person@example.com' }
    let(:new_address) do
      Unit::Types::Address.new(
        street: '55 London Lane',
        city: 'London',
        state: 'London',
        postal_code: 'SE12 5TH',
        country: 'U.K'
      )
    end
    let(:new_phone) { Unit::Types::Phone.new(country_code: '44', number: '3882736173') }

    it 'returns the value if it is already a Types::ApplicationFormPrefill instance' do
      expect(described_class.cast(subject)).to eq subject
    end

    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'instantiates a new instance with the provided attributes' do
      instance = described_class.cast(
        {
          application_type: new_application_type,
          full_name: new_full_name,
          ssn: new_ssn,
          passport: new_passport,
          nationality: new_nationality,
          date_of_birth: new_date_of_birth,
          email: new_email,
          address: new_address,
          phone: new_phone
        }
      )

      expect(instance.application_type).to eq new_application_type
      expect(instance.full_name).to eq new_full_name
      expect(instance.ssn).to eq new_ssn
      expect(instance.passport).to eq new_passport
      expect(instance.nationality).to eq new_nationality
      expect(instance.date_of_birth).to eq new_date_of_birth
      expect(instance.email).to eq new_email
      expect(instance.address).to eq new_address
      expect(instance.phone).to eq new_phone
    end
  end

  describe '#as_json_api' do
    it 'returns a hash with the correct attributes' do
      expect(subject.as_json_api).to eq(
        {
          application_type: application_type,
          full_name: full_name.as_json_api,
          ssn: ssn,
          passport: passport,
          nationality: nationality,
          date_of_birth: date_of_birth,
          email: email,
          address: address.as_json_api,
          phone: phone.as_json_api
        }
      )
    end
  end
end
