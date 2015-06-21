source "https://rubygems.org/"

gem 'sinatra', require: false
gem 'sinatra-contrib', require: false

# required to include Rack::PostBodyContentTypeParser
gem 'rack-contrib'

gem 'pg'
gem 'activerecord'
gem 'sinatra-activerecord'

gem 'active_model_serializers'

group :test do
  gem 'rspec'
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers'
  gem 'database_cleaner'
  gem 'factory_girl'
end

group :development do
  gem 'rake'
end
