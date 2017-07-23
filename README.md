[![Build Status](https://travis-ci.org/abdomazzika/system_dependencies.svg?branch=master)](https://travis-ci.org/abdomazzika/system_dependencies)  [![Coverage Status](https://coveralls.io/repos/github/abdomazzika/system_dependencies/badge.svg?branch=master)](https://coveralls.io/github/abdomazzika/system_dependencies?branch=master)
# SystemDependencies

Ruby gem that would collect all local gems in your project and send them to a web server 
to determine the system libraries you need to install.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'system_dependencies', :git => "git://github.com/abdomazzika/system_dependencies.git"
```

And then execute:

    $ bundle

## Usage

First you need to pass dependencies service api port and root to gem using:
 
```ruby
@my_app = SystemDependencies::Libraries.new('localhost', '3000')
```

you can list all your local gems using:

```ruby
@my_app.local_gems
```
you can list all your operating system info using:

```ruby
@my_app.operating_system_info
```

Also you can retrieve a list of all your local gems system level libraries dependencies
and package manager needed to install them using:

```ruby
@my_app.system_dependencies
```

## Configurations

This gem configured with Travis-CI to run all tests and improving the development cycle
you can find the travis-ci configuration in:

```
.travis.yml
```

And also configured with coverall to check the percentage of your specs code coverage
you can find the coveralls configuration in:
 
```
.coveralls.yml
```
 
## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/system_dependencies.

