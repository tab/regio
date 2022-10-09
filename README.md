# Regio

[![Gem Version](https://badge.fury.io/rb/regio.svg)](https://badge.fury.io/rb/regio)

[Regio geocoding API](https://api.regio.ee/documentation/#docs/geocode) lets you search for addresses from complete Estonian address database.

[Regio](https://www.regio.ee/en/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'regio', '~> 0.1.1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install regio

## Usage

Get your own API key

```shell
REGIO_API_KEY=SECRET
```

Use geocode class in your code

```ruby
require 'regio'

class Geocoding

  private

  def results
    @results ||= Regio::Geocode.new(options).results
  end

  def options
    {
      address: 'Tartu maantee 83',
      country: 'ee'
    }
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tab/regio. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Regio project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/tab/regio/blob/master/CODE_OF_CONDUCT.md).
