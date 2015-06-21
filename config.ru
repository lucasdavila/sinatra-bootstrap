Bundler.require :default, ENV['RACK_ENV']

Dir['./config/initializers/*.rb'].each { |file| require file }
Dir['./lib/models/*.rb'].each { |file| require file }
require './lib/controllers'

map('/') { run HomeController }
