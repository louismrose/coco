#ruby=jruby-1.7.4
ruby '1.9.3', :engine => 'jruby', :engine_version => '1.7.4'
source 'https://rubygems.org'

gem 'rails', '3.2.12'

# Alternative to WEBrick
gem 'puma'

gem 'codemirror-rails'
gem 'twitter-bootstrap-rails'

gem 'activerecord-jdbcsqlite3-adapter', group: [:development, :test]
gem 'activerecord-jdbcpostgresql-adapter', group: [:production]
# gem 'jruby-openssl' causes a lot already initialized constant errors ?

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyrhino'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'