require 'spec_helper'
require 'securerandom'

RSpec.describe Unit::BookPayment do
  before do
    establish_connection_to_api!
  end

  let(:new_individual_customer) do
    Factory.create_individual_customer
  end

  let(:deposit_account) do
    Factory.create_deposit_account(new_individual_customer)
  end

  let(:counterparty_deposit_account) do
    Factory.create_deposit_account(new_individual_customer)
  end

  it 'serializes the counterparty account relationship as a deposit account' do
    payment = Unit::BookPayment.new
    payment.counterparty_account = Unit::DepositAccount.new.tap { |account| account.id = '10000' }

    expect(payment.relationships[:counterparty_account]).to eq(
      data: { type: :depositAccount, id: '10000' }
    )
  end

  it 'creates a book payment between two accounts' do
    payment = Unit::BookPayment.create(
      amount: 10_000,
      description: 'Funding',
      transaction_summary_override: 'Transfer to savings',
      idempotency_key: SecureRandom.uuid,
      account: deposit_account,
      counterparty_account: counterparty_deposit_account,
      tags: { tag1: 'value1' }
    )

    expect(payment.type).to eq 'bookPayment'
    expect(payment.amount).to eq 10_000
    expect(payment.description).to eq 'Funding'
    expect(payment.tags[:tag1]).to eq 'value1'
    expect(payment.account.id).to eq deposit_account.id
    expect(payment.counterparty_account.id).to eq counterparty_deposit_account.id

    expect(Unit::BookPayment.find(payment.id).id).to eq payment.id
    expect(Unit::BookPayment.list(where: { type: ['BookPayment'] })).not_to be_empty
  end
end
