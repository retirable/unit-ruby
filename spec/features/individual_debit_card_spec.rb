require 'spec_helper'
require 'securerandom'

RSpec.describe Unit::IndividualDebitCard do
  before do
    establish_connection_to_api!
  end

  describe '#create' do
    let(:customer) { Factory.create_individual_customer }

    let(:deposit_account) { Factory.create_deposit_account(customer) }

    let(:random_user_id) { rand(10**9).to_s.rjust(9, '0') }

    it 'creates a debit card' do
      debit_card = Unit::IndividualDebitCard.create(
        tags: { userId: random_user_id },
        shipping_address: customer.address,
        idempotency_key: "debit-card-#{random_user_id}",
        customer: customer,
        account: deposit_account
      )

      expect(debit_card.tags[:user_id]).to eq(random_user_id)
      expect(debit_card.shipping_address.street).to eq('123 Main St.')
      expect(debit_card.shipping_address.city).to eq('Brooklyn')
      expect(debit_card.shipping_address.state).to eq('NY')
      expect(debit_card.shipping_address.postal_code).to eq('11211')
      expect(debit_card.shipping_address.country).to eq('US')
    end
  end

  describe '#save' do
    let(:customer) do
      Factory.create_individual_customer
    end
    let(:deposit_account) do
      Factory.create_deposit_account(customer)
    end
    let(:debit_card) do
      Factory.create_debit_card(customer, deposit_account)
    end

    it 'updates the details' do
      debit_card.save(
        { shipping_address: Unit::Types::Address.new(
          street: '389 Congress Street',
          city: 'Portland',
          state: 'ME',
          postal_code: '04101',
          country: 'US'
        ) }
      )
      updated_debit_card = Unit::IndividualDebitCard.find(debit_card.id)
      expect(updated_debit_card.shipping_address.street).to eq('389 Congress Street')
      expect(updated_debit_card.shipping_address.city).to eq('Portland')
      expect(updated_debit_card.shipping_address.state).to eq('ME')
      expect(updated_debit_card.shipping_address.postal_code).to eq('04101')
      expect(updated_debit_card.shipping_address.country).to eq('US')
    end
  end
end
