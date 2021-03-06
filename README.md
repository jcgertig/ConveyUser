# ConveyUser

Gem to make working with Convey a lot easier


## Installation

Add these lines to your application's Gemfile:

```ruby
gem 'convey_user', github: 'jcgertig/ConveyUser'
gem 'omniauth-convey'
```

And then execute:

    $ bundle

And run the setup:

    $ rails g convey_user:setup

Then handle the get of `auth/success` for example:

```ruby
get 'auth/success', to: 'auth#success'
```

## Current User and proof

Inside your controllers you can require that a jwt token is passed this will set the `current_user` for you

```ruby
before_action :require_proof

def profile
  render json: current_user.profile, status: 200
end
```

## Development

In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/convey_user`. To experiment with that code, run `bin/console` for an interactive prompt.

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jcgertig/ConveyUser. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
