require 'spec_helper'

RSpec.describe Unit::Types::ApplicationFormSettingsOverride do
  let(:redirect_url) { 'https://my-company.com/redirect-url' }
  let(:privacy_policy_url) { 'https://my-company.com/privacy-policy-url' }
  let(:electronic_disclosures_url) { 'https://my-company.com/electronic-disclosures-url' }
  let(:deposit_terms_url) { 'https://my-company.com/deposit-terms-url' }
  let(:client_terms_url) { 'https://my-company.com/client-terms-url' }
  let(:cardholder_terms_url) { 'https://my-company.com/cardholder-terms' }
  let(:cash_advanced_terms_url) { 'https://my-company.com/cash-advanced-terms-url' }
  let(:additional_disclosures) { 'https://my-company.com/additional-disclosures' }

  subject do
    described_class.new(
      redirect_url: redirect_url,
      privacy_policy_url: privacy_policy_url,
      electronic_disclosures_url: electronic_disclosures_url,
      deposit_terms_url: deposit_terms_url,
      client_terms_url: client_terms_url,
      cardholder_terms_url: cardholder_terms_url,
      cash_advanced_terms_url: cash_advanced_terms_url,
      additional_disclosures: additional_disclosures
    )
  end

  it 'instantiates an instance of the type' do
    expect(subject.redirect_url).to eq redirect_url
    expect(subject.privacy_policy_url).to eq privacy_policy_url
    expect(subject.electronic_disclosures_url).to eq electronic_disclosures_url
    expect(subject.deposit_terms_url).to eq deposit_terms_url
    expect(subject.client_terms_url).to eq client_terms_url
    expect(subject.cardholder_terms_url).to eq cardholder_terms_url
    expect(subject.cash_advanced_terms_url).to eq cash_advanced_terms_url
    expect(subject.additional_disclosures).to eq additional_disclosures
  end

  describe '#self.cast' do
    let(:new_redirect_url) { 'https://my-company.com/new-redirect-url' }
    let(:new_privacy_policy_url) { 'https://my-company.com/new-privacy-policy-url' }
    let(:new_electronic_disclosures_url) { 'https://my-company.com/new-electronic-disclosures-url' }
    let(:new_deposit_terms_url) { 'https://my-company.com/new-deposit-terms-url' }
    let(:new_client_terms_url) { 'https://my-company.com/new-client-terms-url' }
    let(:new_cardholder_terms_url) { 'https://my-company.com/new-cardholder-terms' }
    let(:new_cash_advanced_terms_url) { 'https://my-company.com/new-cash-advanced-terms-url' }
    let(:new_additional_disclosures) { 'https://my-company.com/new-additional-disclosures' }

    it 'returns the value if it is already a Types::ApplicationFormSettingsOverride instance' do
      expect(described_class.cast(subject)).to eq subject
    end

    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'instantiates a new instance with the provided attributes' do
      instance = described_class.cast(
        {
          redirect_url: new_redirect_url,
          privacy_policy_url: new_privacy_policy_url,
          electronic_disclosures_url: new_electronic_disclosures_url,
          deposit_terms_url: new_deposit_terms_url,
          client_terms_url: new_client_terms_url,
          cardholder_terms_url: new_cardholder_terms_url,
          cash_advanced_terms_url: new_cash_advanced_terms_url,
          additional_disclosures: new_additional_disclosures
        }
      )

      expect(instance.redirect_url).to eq new_redirect_url
      expect(instance.privacy_policy_url).to eq new_privacy_policy_url
      expect(instance.electronic_disclosures_url).to eq new_electronic_disclosures_url
      expect(instance.deposit_terms_url).to eq new_deposit_terms_url
      expect(instance.client_terms_url).to eq new_client_terms_url
      expect(instance.cardholder_terms_url).to eq new_cardholder_terms_url
      expect(instance.cash_advanced_terms_url).to eq new_cash_advanced_terms_url
      expect(instance.additional_disclosures).to eq new_additional_disclosures
    end
  end

  describe '#as_json_api' do
    it 'returns a hash with the correct attributes' do
      expect(subject.as_json_api).to eq(
        {
          redirect_url: redirect_url,
          privacy_policy_url: privacy_policy_url,
          electronic_disclosures_url: electronic_disclosures_url,
          deposit_terms_url: deposit_terms_url,
          client_terms_url: client_terms_url,
          cardholder_terms_url: cardholder_terms_url,
          cash_advanced_terms_url: cash_advanced_terms_url,
          additional_disclosures: additional_disclosures
        }
      )
    end
  end
end
