ruby "1.9.3"
source 'https://rubygems.org'

gem 'grape', '~> 0.2.6' # an opinionated micro-framework for creating REST-like APIs in Ruby

gem 'grape-swagger', '~> 0.3.0' # add swagger compliant documentation to your grape API http://swagger.wordnik.com/
gem 'hiredis', '~> 0.4.5' # C client for Redis
gem 'ohm', '~> 1.2.0' # Object-hash mapping library for Redis. I've had mixed experiences with pre 1.0 versions. Worth keeping an eye on though.
gem 'oj', '~> 2.0.0' # fast JSON parser and Object marshaller
gem 'redis', '~> 3.0.2'
gem 'unicorn', '~> 4.5.0' # rack HTTP server for fast clients and Unix

group :development do
  gem 'awesome_print', '~> 1.1.0'
  gem 'benchmark-ips', '~> 1.2.0' # iterations per second enhancement to Benchmark
  gem 'pry-debugger', '0.2.1'
  gem 'rake', '~> 10.0.3'
  gem 'shotgun', '~> 0.9' # reloading rack development server / forking version of rackup
  gem 'yard', '~> 0.8.3' # documentation generation tool, just run rake docs
end

group :test do
  gem 'guard-minitest', '~> 0.5.0'
  gem 'minitest', '~> 4.5.0'
  gem 'rack-test', '~> 0.6.1'
  gem 'rb-fsevent', '~> 0.9.2'
  gem 'redis_gun', '~> 0.1.0' # quickly spawn many independent redis-server instances
  gem 'turn', '~> 0.9.6'
end
