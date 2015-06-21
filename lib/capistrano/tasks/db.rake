namespace :db do
  desc 'Create db'
  task :create do
    on roles(:db) do
      within "#{current_path}" do
        execute :rake, "RACK_ENV=#{fetch :stage} db:create"
      end
    end
  end

  desc 'Drop db'
  task :drop do
    on roles(:db) do
      within "#{current_path}" do
        execute :rake, "RACK_ENV=#{fetch :stage} db:drop"
      end
    end
  end

  desc 'Migrate db'
  task :migrate do
    on roles(:db) do
      within "#{current_path}" do
        execute :rake, "RACK_ENV=#{fetch :stage} db:migrate"
      end
    end
  end

  desc 'Rollback last migration'
  task :rollback do
    on roles(:db) do
      within "#{current_path}" do
        execute :rake, "RACK_ENV=#{fetch :stage} db:rollback"
      end
    end
  end

  desc "Seed db"
  task :seed do
    on roles(:app) do
      within "#{current_path}" do
        execute :rake, "RACK_ENV=#{fetch :stage} db:seed"
      end
    end
  end
end
