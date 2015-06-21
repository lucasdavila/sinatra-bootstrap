require './lib/controllers/base_controller'
require './lib/controllers/api_controller'
require './lib/controllers/resource_controller'
Dir['./lib/controllers/*.rb'].each { |file| require file }
