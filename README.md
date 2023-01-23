# Documentation

The documentation for the Unit API can be found [here](https://docs.unit.co/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'unit-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install unit-ruby

## Usage

To get started, add an initializer file for the `unit-ruby` gem e.g. in `config/initializers/unit.rb`.

```Ruby
require 'unit-ruby'

Unit.configure do |config|
    config.api_key = ENV['UNIT_API_KEY']
    config.base_url = ENV['UNIT_BASE_URL']
    config.trust_token = ENV['UNIT_TRUST_TOKEN] # optional
end

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Releasing

In order to publish this gem on [RubyGems.org](https://rubygems.org/), you will need to create a RubyGems account. Note that multi-factor authentication must be set up on your account before a gem can be published.

Once your account is set up, the following operations will facilitate publishing the latest version of the gem:

1. Ensure that PR request is approved by appropriate member(s) of the engineering team
2. Update the gem version number in `version.rb`
3. Run `gem build unit-ruby`. This will build a version of the gem called `unit-ruby-[gem version number].gem`
4. Push this latest version of the gem to RubyGems.org by calling `gem push unit-ruby-[gem version number].gem`
5. Commit `version.rb` file
6. Merge PR into `main` branch

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/retirable/unit-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Unit project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/retirable/unit-ruby/blob/master/CODE_OF_CONDUCT.md).
