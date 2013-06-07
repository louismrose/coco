#ruby=jruby-1.7.4
ruby '1.9.3', :engine => 'jruby', :engine_version => '1.7.4'
source 'https://rubygems.org'

gem 'rails', '~> 4.0.0.rc1'
gem 'turbolinks'
gem 'jbuilder', '~> 1.0.1'

# For assests (not stored in their own bundler group since Rails 4)
gem 'sass-rails',   '~> 4.0.0.rc1'
gem 'coffee-rails', '~> 4.0.0.rc1'
gem 'uglifier', '>= 1.3.0'

# Alternative to WEBrick server
gem 'puma'

# Logging and asset pipeline on Heroku
group :production do
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
end

# GUI
gem 'codemirror-rails'
gem 'twitter-bootstrap-rails'
gem 'jquery-rails'

# Queueing
gem 'resque', '~> 1.24.0', :require => 'resque/server'

# Database connectivity
gem 'activerecord-jdbcsqlite3-adapter', '~> 1.3.0.beta1', group: [:development, :test]
gem 'activerecord-jdbcpostgresql-adapter', '~> 1.3.0.beta1', group: [:production]


group :test do
  gem 'rspec', '~> 2.13.0'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end