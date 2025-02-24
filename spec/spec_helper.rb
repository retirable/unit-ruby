require 'bundler/setup'
require 'dotenv/load'
require 'pry'
require 'unit-ruby'
require 'rspec/file_fixtures'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def establish_connection_to_api!
  Unit.configure do |config|
    config.api_key = ENV.fetch('UNIT_API_KEY', nil)
    config.base_url = ENV.fetch('UNIT_BASE_URL', nil)
  end
end

module Factory
  def self.create_individual_customer
    unique_ssn = rand(10**9).to_s.rjust(9, '0')

    application = Unit::IndividualApplication.create(
      full_name: Unit::Types::FullName.new(first: 'John', last: 'Doe'),
      email: 'automated_testing+johndoe@example.com',
      ssn: unique_ssn,
      phone: Unit::Types::Phone.new(country_code: '1', number: '5555555555'),
      occupation: 'ArchitectOrEngineer',
      address: Unit::Types::Address.new(
        street: '123 Main St.', city: 'Brooklyn', state: 'NY', postal_code: '11211', country: 'US'
      ),
      date_of_birth: '2000-01-01',
      tags: {
        userId: 'random-user-id'
      }
    )
    application.customer
  end

  def self.create_deposit_account(customer)
    Unit::DepositAccount.create(deposit_product: 'checking', customer: customer)
  end

  def self.create_debit_card(customer, deposit_account)
    random_user_id = rand(10**9).to_s.rjust(9, '0')

    Unit::IndividualDebitCard.create(
      tags: { userId: random_user_id },
      shipping_address: customer.address,
      idempotency_key: "debit-card-#{random_user_id}",
      customer: customer,
      account: deposit_account
    )
  end

  def self.create_ach_counterparty(customer)
    random_user_id = rand(10**9).to_s.rjust(9, '0')

    Unit::AchCounterparty.create(
      name: 'Test Counterparty',
      routing_number: '021000021',
      account_number: '123456789',
      account_type: 'Checking',
      type: 'Person',
      customer: customer,
      idempotency_key: "ach-counterparty-#{random_user_id}",
      tags: { userId: random_user_id }
    )
  end
end
