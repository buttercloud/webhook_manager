# WebhookManager

A gem that integrates the https://gethooky.com API for plain Ruby or Ruby on Rails applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'webhook_manager'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install webhook_manager

## Usage

1. Initialize the class with your Hooky API key:

```
client = WebhookManager::Webhook.new(HOOKY_API_KEY)
```

2. Send your webhook

Note: Payload expect a Ruby Hash. It will be automatically converted to JSON

```
client.trigger!(event_name: "any.event.name", payload: {foo: "bar"})
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/webhook_manager.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
