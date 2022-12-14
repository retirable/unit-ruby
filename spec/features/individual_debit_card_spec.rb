require 'spec_helper'

RSpec.describe Unit::IndividualDebitCard do
  before do
    establish_connection_to_api!
  end

  let(:new_individual_customer) do
    Factory.create_individual_customer
  end

  let(:deposit_account) do
    card = Unit::DepositAccount.create(deposit_product: 'checking', customer: new_individual_customer)
  end

  let(:individual_debit_card) do
    Unit::IndividualDebitCard.create(account: deposit_account, customer: new_individual_customer, shipping_address: new_individual_customer.address)
  end

  it 'reports a stolen card' do
    skip 'Need an active card to test this, however physical cards can only be activated through VGS'

    individual_debit_card.report_stolen

    expect(individual_debit_card.status).to eq 'Stolen'
  end

  it 'reports a lost card' do
    skip 'Need an active card to test this, however physical cards can only be activated through VGS'

    individual_debit_card.report_lost

    expect(individual_debit_card.status).to eq 'Lost'
  end

  it 'closes a card' do
    individual_debit_card.close

    expect(individual_debit_card.status).to eq 'ClosedByCustomer'
  end

  it 'freezes a card' do
    skip 'Need an active card to test this, however physical cards can only be activated through VGS'

    individual_debit_card.freeze

    expect(individual_debit_card.status).to eq 'Frozen'
  end

  it 'unfreezes a card' do
    skip 'Need an active card to test this, however physical cards can only be activated through VGS'

    individual_debit_card.freeze
    individual_debit_card.unfreeze

    expect(individual_debit_card.status).to eq 'Active'
  end

  it 'replaces a card' do
    individual_debit_card.replace

    expect(individual_debit_card.status).to eq 'Inactive'
  end

  it 'replaces a card with a shipping address' do
    individual_debit_card.replace(shipping_address: Unit::Types::Address.new(
        street: '456 2nd Ave.', city: 'Brooklyn', state: 'NY', postal_code: '11211', country: 'US'
    ))

    expect(individual_debit_card.status).to eq 'Inactive'
    expect(individual_debit_card.shipping_address.street).to eq('456 2nd Ave.')
  end
end
