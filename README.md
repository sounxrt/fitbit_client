# FitbitClient

[![Build Status](https://travis-ci.org/sounxrt/fitbit_client.svg?branch=master)](https://travis-ci.org/sounxrt/fitbit_client) [![Code Climate](https://codeclimate.com/github/sounxrt/fitbit_client/badges/gpa.svg)](https://codeclimate.com/github/sounxrt/fitbit_client) [![Test Coverage](https://codeclimate.com/github/codeclimate/codeclimate/badges/coverage.svg)](https://codeclimate.com/github/codeclimate/codeclimate/coverage)

Provides access to the Fitbit API using OAuth2

- The version of the API for most endpoints is the 1, and 1.2 for the ones were was available.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fitbit_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fitbit_client

## Usage

To create an instance of the Client
```
client = FitbitClient::Client.new(access_token, refresh_token, { client_id: 'fitbit_app_client_id', client_secret: 'fitbit_app_client_secret' })
```

**Note:** `access_token` and `refresh_token` must come from a valid OAuth2 session. 

### Rails

You can add an initializer to set the client_id and client_secret configuration values:

```
FitbitClient.configure do |config|
  config.client_id = ENV['FITBIT_CLIENT_ID']
  config.client_secret = ENV['FITBIT_CLIENT_SECRET']
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sounxrt/fitbit_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FitbitClient project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/fitbit_client/blob/master/CODE_OF_CONDUCT.md).
