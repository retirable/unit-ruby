# Unit Ruby

![Gem Version](https://img.shields.io/gem/v/unit-ruby)
[![Ruby](https://github.com/retirable/unit-ruby/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/retirable/unit-ruby/actions/workflows/ci.yml)
![GitHub License](https://img.shields.io/github/license/retirable/unit-ruby)

A Ruby SDK for the [Unit's Banking-as-a-Service API](https://docs.unit.co/).

> [!IMPORTANT]
>
> The development of the `unit-ruby` gem is sponsored and used in production by [Retirable](https://retirable).
>
> If you are starting a new project, you might want to consider Unit's officially supported gem, [`unit-ruby-sdk`](https://github.com/unit-finance/unit-ruby-sdk)

## Features

- Ruby SDK for Unit's Banking-as-a-Service API
- Support for all major Unit API endpoints
- Built-in error handling and response parsing
- Production-ready and battle-tested by Retirable
- Ruby 3.3+ compatibility

## Installation

> **Requirements:** Ruby 3.3+

Add this line to your application's Gemfile:

```ruby
gem 'unit-ruby'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install unit-ruby
```

## Configuration

Configure the library with your credentials from Unit, (e.g., in `config/initializers/unit.rb` if you are using Ruby on Rails):

```ruby
require 'unit-ruby'

Unit.configure do |config|
  config.api_key = ENV['UNIT_API_KEY'] # Your Unit API key (required)
  config.base_url = ENV['UNIT_BASE_URL'] # Unit API base URL (required)
  config.trust_token = ENV['UNIT_TRUST_TOKEN'] # Trust token for enhanced security (optional, requires additional configuration from Unit's support team)
end
```

## Usage

```Ruby
my_user_id = 'some-user-id-from-your-app'

# Create an Individual Application
application = Unit::IndividualApplication.create(
    full_name: Unit::Types::FullName.new(first: 'John', last: 'Doe'),
    email: 'individual@example.com',
    ssn: rand(10**9).to_s.rjust(9, '0'),
    phone: Unit::Types::Phone.new(country_code: '1', number: '5555555555'),
    occupation: 'ArchitectOrEngineer',
    address: Unit::Types::Address.new(
        street: '123 Main St.',
        city: 'Brooklyn',
        state: 'NY',
        postal_code: '11211',
        country: 'US'
    ),
    date_of_birth: '2000-01-01',
    tags: {
      externalUserId: my_user_id
    }
)

customer = application.customer

deposit_account = Unit::DepositAccount.create(
    deposit_product: 'checking',
    customer: customer
)

debit_card = Unit::IndividualDebitCard.create(
    idempotency_key: "debit-card-for-#{my_user_id}",
    customer: customer,
    account: deposit_account,
    shipping_address: customer.address,
    tags: { externalUserId: my_user_id }
)
```

> [!TIP]
>
> Refer to the examples in `./spec/**` for further examples

## Development

After checking out the repo, install dependencies:

```bash
$ bin/setup
```

Run the tests:

```bash
$ bin/test
```

For an interactive prompt to experiment with the gem:

```bash
$ bin/console
```

To install this gem onto your local machine:

```bash
$ bundle exec rake install
```

## Releasing

In order to publish this gem on [RubyGems.org](https://rubygems.org/), you will need to create a RubyGems account. Note that multi-factor authentication must be set up on your account before a gem can be published.

Once your account is set up, the following operations will facilitate publishing the latest version of the gem:

1. After making your changes to the gem, update the version number in `version.rb` and open a PR for review using semantic versioning
2. Ensure that PR request is approved by appropriate member(s) of the engineering team before publishing the gem in the below steps
3. Run `gem build unit-ruby`. This will build a version of the gem called `unit-ruby-[gem version number].gem`
4. Push this latest version of the gem to RubyGems.org by calling `gem push unit-ruby-[gem version number].gem`
5. Merge PR into `main` branch

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/retirable/unit-ruby.

## Code of Conduct

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Code of Conduct](https://github.com/retirable/unit-ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
