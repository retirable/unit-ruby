require 'spec_helper'
require 'securerandom'

RSpec.describe Unit::DepositAccount do
  before do
    establish_connection_to_api!
  end

  let(:customer) do
    Factory.create_individual_customer
  end

  it 'updates the customer' do
    customer.save(
      { tags: { userId: 'new-id' },
        address: Unit::Types::Address.new(
          street: '389 Congress Street',
          city: 'Portland',
          state: 'ME',
          postal_code: '04101',
          country: 'US'
        ),
        email: 'new-mail@email.com' }
    )

    updated_customer = Unit::IndividualCustomer.find(customer.id)
    address = updated_customer.address

    expect(updated_customer.tags[:user_id]).to eq('new-id')
    expect(updated_customer.email).to eq('new-mail@email.com')
    expect(address.street).to eq('389 Congress Street')
    expect(address.city).to eq('Portland')
    expect(address.state).to eq('ME')
    expect(address.postal_code).to eq('04101')
    expect(address.country).to eq('US')
  end
end
