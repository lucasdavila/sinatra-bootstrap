# $:.unshift 'lib'

task :default => :spec

def env
  ENV['RACK_ENV'] ? ENV['RACK_ENV'] : 'development'
end

namespace :db do
  require 'bundler'
  require 'yaml'
  require 'active_record'
  require 'active_support/inflector'

  desc 'Create db'
  task :create do
    puts "Creating db #{db_config} on env #{env}"

    ActiveRecord::Base.establish_connection db_config.merge('database' => 'postgres')
    ActiveRecord::Base.connection.create_database db_config['database']
    ActiveRecord::Base.establish_connection db_config
  end

  desc 'Drop db'
  task :drop do
    puts "Dropping db #{db_config} on env #{env}"

    ActiveRecord::Base.establish_connection db_config.merge('database' => 'postgres')
    ActiveRecord::Base.connection.drop_database db_config['database']
  end

  desc 'Migrate DB'
  task :migrate do
    ActiveRecord::Base.establish_connection db_config
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate 'db/migrate'
  end

  desc 'Rollback last migration'
  task :rollback do
    ActiveRecord::Base.establish_connection db_config
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.rollback 'db/migrate'
  end

  # copied from https://github.com/janko-m/sinatra-activerecord/blob/master/lib/sinatra/activerecord/tasks.rake
  desc "Generate a migration (parameters: NAME, VERSION)"
    task :generate_migration do
      unless ENV["NAME"]
        puts "No NAME specified. Example usage: `rake db:create_migration NAME=create_users`"
        exit
      end

      name = ENV["NAME"]
      version = ENV["VERSION"] || Time.now.utc.strftime("%Y%m%d%H%M%S")

      ActiveRecord::Migrator.migrations_paths.each do |directory|
        next unless File.exist?(directory)

        migration_files = Pathname(directory).children

        if duplicate = migration_files.find { |path| path.basename.to_s.include?(name) }
          puts "Another migration is already named \"#{name}\": #{duplicate}."
          exit
        end
      end

      filename = "#{version}_#{name}.rb"
      dirname = ActiveRecord::Migrator.migrations_path
      path = File.join(dirname, filename)

      FileUtils.mkdir_p(dirname)
      File.write path, <<-MIGRATION.strip_heredoc
        class #{name.camelize} < ActiveRecord::Migration
          def change
          end
        end
      MIGRATION

      puts path
    end

  def db_config
    @db_config ||= YAML.load_file("config/database.yml")[env]
  end
end

desc 'Console'
task :console do
  require 'bundler'
  Bundler.require :default, env

  Dir['./config/initializers/*.rb'].each { |file| require file }
  Dir['./lib/models/*.rb'].each { |file| require file }
  Dir['./lib/serializers/*.rb'].each { |file| require file }

  require 'irb'
  require 'irb/completion'

  ARGV.clear
  IRB.start
end
