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

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/retirable/unit-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Unit project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/retirable/unit-ruby/blob/master/CODE_OF_CONDUCT.md).
