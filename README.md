# assert_zone

This small utility will help you verify that a DNS server is responding with the correct information, based on a zone file.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'assert_zone'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install assert_zone

## Usage

It's simple: `assert_zone ZONE_FILE [NAMESERVER] [options]`

Assuming you have a zone file named `zone.txt` in the current directory, you can run `assert_zone zone.txt` to verify that each record in the zone file matches what the nameserver responds with.

You can also specify a nameserver: `assert_zone zone.txt ns1.example.com`.

There are a few option flags you can add to the command:

* `--color` will display the results in color

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dwradcliffe/assert_zone.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
