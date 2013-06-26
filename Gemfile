#ruby=jruby-1.7.3
ruby '1.9.3', :engine => 'jruby', :engine_version => '1.7.3'
source 'https://rubygems.org'

gem 'rails', '~> 4.0.0'
gem 'turbolinks'
gem 'jbuilder', '~> 1.0.1'

# For assets (not stored in their own bundler group since Rails 4)
gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'

# Alternative to WEBrick server
gem 'puma'

# Logging and asset pipeline on Heroku
gem 'rails_12factor', group: :production

# GUI
gem 'codemirror-rails'
gem 'twitter-bootstrap-rails'
gem 'jquery-rails'

# Queueing
gem 'resque', '~> 1.24.0', :require => 'resque/server'

# Database connectivity
gem 'activerecord-jdbcpostgresql-adapter', '~> 1.3.0.beta1'


group :test do
  gem 'rspec', '~> 2.13.0'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end