This is a sinatra bootstrat app ready to implement a json api or a frontend app.

# Features:

* Ready to use Active Record.  
* Ready to implement JSON APIs.  
* Ready to test with Rspec (it also includes shoulda-matchers, database_cleaner and factory_girl).  
* Ready to deploy with capistrano.

# Rake tasks

It includes some useful tasks, such:

* database tasks:
  * db:create  
  * db:destroy  
  * db:generate_migration NAME=create_pets  
  * db:migrate  
  * db:rollback  

* console

# Deploy tasks

It includes some useful capistrano tasks, such:

* database tasks:
  * db:create  
  * db:destroy  
  * db:migrate  
  * db:rollback  
  * db:seed  

* upload tasks:  
  * upload:db_config
  * upload:vhost

## First steps

### create your custom configs
`$ cp config/database.sample.yml config/database.yml`

## Test

### setup the database
`$ rake RACK_ENV=test db:create`  
`$ rake RACK_ENV=test db:migrate`

### run the tests
`$ rspec`

## Development

### setup the database
`$ rake db:create`  
`$ rake db:migrate`

### run the console
`$ rake console`

### run the app with
`$ rackup`

## Production

### create your custom deploy config
`$ cp config/deploy/production.sample.conf config/deploy/production.conf`  
`$ cp config/deploy/staging.sample.conf config/deploy/staging.conf`  

### create your custom apache virtual host
`$ cp config/apache.sample.conf config/apache.conf`

### upload your custom virtual host
`$ cap production upload:vhost`

### upload your custom configs
`$ cap production upload:db_config`  

### deploy it
`$ cap production deploy`

### setup the database
`$ cap production db:create`  
`$ cap production db:migrate`  

Yay, your app is online :D


## TODO

* Move resource_controller to a sinatra module?
