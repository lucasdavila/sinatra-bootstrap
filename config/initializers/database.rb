require 'active_record'
require 'yaml'

module Initializers
  module Database
    def establish_db_connection!
      ActiveRecord::Base.establish_connection config[ENV['ENV']]
    end

    def config
      YAML.load_file "config/database.yml"
    end

    module_function :establish_db_connection!, :config
  end
end

# Initializers::Database.establish_db_connection!
