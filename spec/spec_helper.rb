require 'bundler/setup'
require 'dotenv/load'
require 'pry'
require 'unit-ruby'

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
    config.api_key = ENV['UNIT_API_KEY']
    config.base_url = ENV['UNIT_BASE_URL']
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
      address: Unit::Types::Address.new(
        street: '123 Main St.', city: 'Brooklyn', state: 'NY', postal_code: '11211', country: 'US'
      ),
      date_of_birth: '2000-01-01'
    )
    application.customer
  end
end
