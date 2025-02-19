require 'spec_helper'
require 'securerandom'

RSpec.describe Unit::RecurringCreditAchPayment do
  before do
    establish_connection_to_api!
  end

  let(:customer) { Factory.create_individual_customer }

  let(:deposit_account) { Factory.create_deposit_account(customer) }

  let(:counterparty) { Factory.create_ach_counterparty(customer) }

  let(:random_user_id) { rand(10**9).to_s.rjust(9, '0') }

  let(:today) { Date.today }
  let(:one_year_from_today) { today >> 12 }

  it 'manages the resource lifecycle' do
    # Create
    recurring_payment = Unit::RecurringCreditAchPayment.create(
      amount: 1000,
      description: 'Test Pmt',
      addenda: 'Some additional description',
      schedule: Unit::Types::Schedule.new(
        interval: 'Monthly',
        start_time: today,
        end_time: one_year_from_today,
        day_of_month: -2,
        day_of_week: nil,
        total_number_of_payments: 12
      ),
      account: deposit_account,
      counterparty: counterparty,
      tags: { userId: random_user_id }
    )
    expect(recurring_payment.amount).to eq 1000
    expect(recurring_payment.description).to eq 'Test Pmt'
    expect(recurring_payment.addenda).to eq 'Some additional description'
    expect(recurring_payment.schedule.interval).to eq 'Monthly'
    expect(recurring_payment.schedule.start_time).to eq today
    expect(recurring_payment.schedule.end_time).to eq one_year_from_today
    expect(recurring_payment.schedule.day_of_month).to eq(-2)
    expect(recurring_payment.schedule.total_number_of_payments).to eq 12
    expect(recurring_payment.counterparty.id).to eq counterparty.id
    expect(recurring_payment.account.id).to eq deposit_account.id

    # Find
    existing_recurring_payment = Unit::RecurringCreditAchPayment.find(recurring_payment.id)
    expect(existing_recurring_payment).to have_attributes(
      id: recurring_payment.id,
      amount: recurring_payment.amount,
      description: recurring_payment.description,
      addenda: recurring_payment.addenda
    )

    # Disable/Enable
    expect(recurring_payment.status).to eq 'Active'
    recurring_payment.disable
    expect(recurring_payment.status).to eq 'Disabled'
    recurring_payment.enable
    expect(recurring_payment.status).to eq 'Active'

    # Delete
    recurring_payment.destroy
    expect(recurring_payment.status).to eq 'Deleted'
  end
end
