require 'spec_helper'
require 'securerandom'

RSpec.describe Unit::AchCounterparty do
  before do
    establish_connection_to_api!
  end

  let(:new_individual_customer) do
    Factory.create_individual_customer
  end

  it 'creates a counter party' do
    counterparty = Unit::AchCounterparty.create(
      idempotency_key: SecureRandom.uuid,
      name: 'Jane Doe',
      routing_number: '812345678',
      account_number: '12345569',
      account_type: 'Checking',
      type: 'Person',
      tags: { tag1: 'value1', tag2: 'value2' },
      customer: new_individual_customer
    )

    expect(counterparty.name).to eq 'Jane Doe'
    expect(counterparty.routing_number).to eq '812345678'
    expect(counterparty.account_number).to eq '12345569'
    expect(counterparty.account_type).to eq 'Checking'
    expect(counterparty.type).to eq 'Person'
    expect(counterparty.tags[:tag1]).to eq 'value1'
    expect(counterparty.tags[:tag2]).to eq 'value2'
    expect(counterparty.customer.id).to eq new_individual_customer.id

    expect(Unit::AchCounterparty.find(counterparty.id).id).to eq counterparty.id
    expect(
      Unit::AchCounterparty.list(where: { customer_id: new_individual_customer.id })
    ).not_to be_empty
  end
end
