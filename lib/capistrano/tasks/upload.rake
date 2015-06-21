namespace :upload do
  desc "Upload database.yml file"
  task :db_config do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! StringIO.new(File.read("config/database.yml")), "#{shared_path}/config/database.yml"
    end
  end

  desc "Upload apache.conf file"
  task :vhost do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! StringIO.new(File.read("config/apache.conf")), "#{shared_path}/config/apache.conf"
    end

    puts "\n"
    puts "It looks like I can't run sudo commands on server :/"
    puts "Please run the following commands in the server to finish the apache config:"
    puts "\n"
    puts "ssh -t user@server sudo cp #{shared_path}/config/apache.conf /etc/apache2/sites-available/<app>.conf"
    puts "ssh -t user@server sudo a2ensite <app>.conf"
  end
end
