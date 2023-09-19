require 'spec_helper'
require 'securerandom'

RSpec.describe Unit::DepositAccount do
  before do
    establish_connection_to_api!
  end

  let(:customer) do
    Factory.create_individual_customer
  end

  context 'when creating an account for an individual customer' do
    it 'creates a deposit account for the customer' do
      account = Unit::DepositAccount.create(deposit_product: 'checking', customer: customer)

      expect(account.id).to_not be nil
      expect(account.customer.id).to eq customer.id
      expect(account.status).to eq 'Open'
      expect(account.routing_number).to_not be nil
      expect(account.account_number).to_not be nil
      expect(account.balance).to_not be nil
      expect(account.hold).to_not be nil
      expect(account.available).to_not be nil
      expect(account.deposit_product).to eq 'checking'
      expect(account.currency).to eq 'USD'
      expect(account.freeze_reason).to eq nil
      expect(account.close_reason).to eq nil

      expect(account.customers.first.id).to eq customer.id
    end

    let(:deposit_account) do
      Factory.create_deposit_account(customer)
    end

    it 'updates the deposit account information' do
      deposit_account.save({ tags: { userId: 'new-user-id' } })
      updated_deposit_account = Unit::DepositAccount.find(deposit_account.id)
      expect(updated_deposit_account.tags[:user_id]).to eq('new-user-id')
    end
  end

  context 'when creating an account with multiple owners' do
    let(:another_customer) do
      Factory.create_individual_customer
    end

    it 'creates a deposit account for both customers' do
      account = Unit::DepositAccount.create(deposit_product: 'checking',
                                            customers: [
                                              customer, another_customer
                                            ])
      expect(account.id).to_not be nil
      expect(account.customers.map(&:id)).to include(customer.id, another_customer.id)
      expect(account.status).to eq 'Open'
      expect(account.routing_number).to_not be nil
      expect(account.account_number).to_not be nil
      expect(account.balance).to_not be nil
      expect(account.hold).to_not be nil
      expect(account.available).to_not be nil
      expect(account.deposit_product).to eq 'checking'
      expect(account.currency).to eq 'USD'
      expect(account.freeze_reason).to eq nil
      expect(account.close_reason).to eq nil

      expect(account.customers.first.id).to eq customer.id
    end
  end
end
