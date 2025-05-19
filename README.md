# ISBN Field

A Ruby gem for validating ISBN-10 and ISBN-13 numbers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'isbn_field'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install isbn_field
```

## Usage

```ruby
require 'isbn_field'

# Validate an ISBN-10 number
result, message = IsbnField.validate("0471958698")
# result => true
# message => "validation pass"

# Validate an ISBN-10 number with hyphens
result, message = IsbnField.validate("0-471-95869-8")
# result => true
# message => "validation pass"

# Validate an ISBN-10 number with 'X' as check digit
result, message = IsbnField.validate("155404295X")
# result => true
# message => "validation pass"

# Validate an ISBN-13 number
result, message = IsbnField.validate("9780306406157")
# result => true
# message => "validation pass"

# Validate an ISBN-13 number with hyphens
result, message = IsbnField.validate("978-0-306-40615-7")
# result => true
# message => "validation pass"

# Invalid format
result, message = IsbnField.validate("abc")
# result => false
# message => "wrong format"

# Valid format but invalid checksum
result, message = IsbnField.validate("0471958697")
# result => false
# message => "validation failed"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).