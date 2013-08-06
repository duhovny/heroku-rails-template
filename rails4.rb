# Rails 4 Application Generator
# Resultant is 100% deployable to Heroku with no further changes


# Helper methods
def source_paths
  [File.expand_path(File.dirname(__FILE__))]
end

# Add unicorn
gem 'unicorn'

# Add Heroku specific Gems
gem_group :production do
  gem 'rails_12factor'
end

# Switch from Sqlite3 to Postgres
gsub_file 'Gemfile', 'sqlite3', 'pg'

# Add Unicorn config
copy_file 'files/common/config/unicorn.rb', 'config/unicorn.rb'

# Add a Procfile
copy_file 'files/common/Procfile', 'Procfile'

# Remove database.yml
remove_file 'config/database.yml'

# Replace with postgres friendly database.yml
copy_file 'files/common/config/database.yml', 'config/database.yml'

# Replace development database name with one extracted from application name
gsub_file "config/database.yml", /database: myapp_development/, "database: #{app_name.downcase}_development"
