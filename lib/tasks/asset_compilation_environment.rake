# Workaround to get asset precompilation working on Heroku

# We override the assets:environment Rake task from sprockets-rails so that
# we can fix the DATABSE_URL passed by Heroku before loading the Rails environment.

# Heroku does not make available environment variables, etc during asset precompilation.
# Instead, Heroku is passing a dummy DATABASE_URL to the sprockets-rails rake task.
# Unfortuantely, the DATABASE_URL seems to be malformed, as it does not have a scheme.
# Here we prepend a scheme corresponding to the database adapter that we are using in
# the production environment.

Rake::Task['assets:environment'].clear
namespace :assets do
  task :environment do
    fix_database_url
    Rake::Task['environment'].invoke
  end
  
  # Adds a scheme to the url, if there isn't one already
  def fix_database_url
    if ENV["DATABASE_URL"].start_with? "://"
      ENV["DATABASE_URL"] = "postgres" + ENV["DATABASE_URL"]
    end
  end
end