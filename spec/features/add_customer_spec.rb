require 'spec_helper'
require 'securerandom'

RSpec.describe Unit::DepositAccount do
  before do
    establish_connection_to_api!
  end

  let(:first_individual_customer) do
    Factory.create_individual_customer
  end

  let(:second_individual_customer) do
    Factory.create_individual_customer
  end

  let(:deposit_account) do
    Unit::DepositAccount.create(
      deposit_product: 'checking',
      customer: first_individual_customer
    )
  end

  it 'adds a new customer to the deposit account' do
    account = deposit_account.add_customer(
      second_individual_customer.id
    )

    expect(account.customers.length).to eq 2
    expect(account.customers.map(&:id)).to eq [
      first_individual_customer.id,
      second_individual_customer.id

    ]
  end
end
