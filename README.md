# Regio

[![Gem Version](https://badge.fury.io/rb/regio.svg)](https://badge.fury.io/rb/regio)
[![Release](https://github.com/tab/regio/actions/workflows/release.yaml/badge.svg?event=release)](https://github.com/tab/regio/actions/workflows/release.yaml)

[Regio geocoding API](https://api.regio.ee/documentation/#docs/geocode) lets you search for addresses from complete Estonian address database.

[Regio](https://www.regio.ee/en/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'regio', '~> 0.3.5'
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

```
export REGIO_API_KEY=SECRET && irb -I lib

irb(main):001:0> require 'regio'
=> true

...
```

### Geocoding

Use `Geocode` class in your code

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

Check Regio [geocode](https://api.regio.ee/documentation/#docs/geocode) documentation

### Reverse geocoding

Use `ReverseGeocode` class in your code

```ruby
require 'regio'

class Geocoding

  private

  def results
    @results ||= Regio::ReverseGeocode.new(options).results
  end

  def options
    {
      lat: 59.4276340999273,
      lng: 24.7790924770962
    }
  end
end
```

Check Regio [reverse geocode](https://api.regio.ee/documentation/#docs/reverse_geocode) documentation

### Gazetteer

Use `Gazetteer` class in your code

```ruby
require 'regio'

class Geocoding

  private

  def results
    @results ||= Regio::Gazetteer.new(options).results
  end

  def options
    {
      id: 16004253,
      query: 'address_children'
    }
  end
end
```

Check Regio [Gazetteer](https://api.regio.ee/documentation/#docs/gazetteer) documentation

### Routing and directions

Use `Routing` class in your code

```ruby
require 'regio'

class Routing

  private

  def results
    @results ||= Regio::Routing.new(options).results
  end

  def options
    {
      coordinates: [[24.649138022268, 59.14048887149], [25.853136227622, 59.00678681919]],
      service: 'optimize',
      overview: 'full'
    }
  end
end
```

Check Regio [routing and directions](https://api.regio.ee/documentation/#docs/routing_and_directions) documentation

## Development

Build docker container with compose:

```bash
docker-compose build
docker-compose up
```

Access to the container:

```bash
docker-compose exec regio sh
```

Run rspec or rubocop checks:

```bash
/package # bundle exec rubocop
/package # bundle exec rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tab/regio. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Regio project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/tab/regio/blob/master/CODE_OF_CONDUCT.md).
