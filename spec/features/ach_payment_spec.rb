require 'spec_helper'

RSpec.describe Unit::AchPayment do
  before do
    establish_connection_to_api!
  end

  let(:new_individual_customer) do
    Factory.create_individual_customer
  end

  let(:deposit_account) do
    Unit::DepositAccount.create(deposit_product: 'checking', customer: new_individual_customer)
  end

  it 'creates a payment to an inline counterparty' do
    counterparty = Unit::Types::Counterparty.new(
      name: 'Jane Doe',
      routing_number: '812345678',
      account_number: '12345569',
      account_type: 'Checking'
    )
    payment = Unit::AchPayment.create(
      amount: 12_300,
      direction: 'Credit',
      description: 'MyCompany',
      addenda: 'MyCompany monthly payment',
      idempotency_key: SecureRandom.base64,
      counterparty: counterparty,
      account: deposit_account,
      tags: { tag1: 'value1', tag2: 'value2' }
    )

    expect(payment.amount).to eq 12_300
    expect(payment.direction).to eq 'Credit'
    expect(payment.counterparty.name).to eq 'Jane Doe'
    expect(payment.tags[:tag1]).to eq 'value1'
    expect(payment.tags[:tag2]).to eq 'value2'
    expect(payment.customer.id).to eq new_individual_customer.id

    expect(Unit::AchPayment.find(payment.id).id).to eq payment.id
    expect(Unit::AchPayment.list).not_to be_empty
  end
end
