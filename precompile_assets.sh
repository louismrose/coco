# Precompile assets locally. This script should be executed before deploying
# to Heroku any change that affects assets (e.g. CSS, JS, images)

# I'd prefer to have Heroku precompile assets during slug compilation, but this 
# doesn't work at present. The issue seems to be that Heroku passes an invalid
# database URI to Rails, possibly because Heroku can't detect the database type
# from the Gemfile as we're using "unusual" database abapters that work with
# JRuby. It looks as though the scheme part of the database URI is missing, 
# which causes asset precompilation to fail with an exception
RAILS_ENV=production bundle exec rake assets:precompile