require 'spec_helper'

RSpec.describe Unit::IndividualVirtualDebitCard do
  before do
    establish_connection_to_api!
  end

  let(:new_individual_customer) do
    Factory.create_individual_customer
  end

  let(:deposit_account) do
    card = Unit::DepositAccount.create(deposit_product: 'checking', customer: new_individual_customer)
  end

  let(:individual_virtual_debit_card) do
    Unit::IndividualVirtualDebitCard.create(account: deposit_account, customer: new_individual_customer)
  end
  
  it 'reports a stolen card' do
    individual_virtual_debit_card.report_stolen

    expect(individual_virtual_debit_card.status).to eq 'Stolen'
  end

  it 'reports a lost card' do
    individual_virtual_debit_card.report_lost

    expect(individual_virtual_debit_card.status).to eq 'Lost'
  end

  it 'closes a card' do
    individual_virtual_debit_card.close

    expect(individual_virtual_debit_card.status).to eq 'ClosedByCustomer'
  end

  it 'freezes a card' do
    individual_virtual_debit_card.freeze

    expect(individual_virtual_debit_card.status).to eq 'Frozen'
  end

  it 'unfreezes a card' do
    individual_virtual_debit_card.freeze
    individual_virtual_debit_card.unfreeze

    expect(individual_virtual_debit_card.status).to eq 'Active'
  end
end
