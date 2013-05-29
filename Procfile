web: bundle exec rails server puma -p $PORT -e $RACK_ENV
worker: env TERM_CHILD=1 RESQUE_TERM_TIMEOUT=10 bundle exec rake resque:work QUEUE='*'