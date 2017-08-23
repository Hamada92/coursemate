lock "3.9.0"
set :application, "coursemate"
set :repo_url, "git@github.com:Hamada92/coursemate.git"
set :user, "ahmad"
set :rbenv_ruby, '2.3.0'
set :rbenv_path, "/home/ahmad/.rbenv"
set :conditionally_migrate, true
set :migration_role, :all
set :assets_roles, [:all]
set :deploy_to, "/var/www/coursemate/"
set :whenever_roles, :all
append :linked_files, "config/database.yml", "config/application.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets"

namespace :deploy do 
  task :reload_unicorn do 
    on roles(:all) do 
      info "reloading unicorn for zero down time deployment"
      execute "sudo systemctl reload unicorn.service"
    end
  end
end

namespace :deploy do 
  task :stop_sidekiq do 
    on roles(:all) do 
      info "stopping sidekiq"
      execute "sudo systemctl stop sidekiq.service"
    end
  end

  task :start_sidekiq do 
    on roles(:all) do 
      info "starting sidekiq"
      execute "sudo systemctl start sidekiq.service"
    end
  end
end

after 'deploy:symlink:release', 'deploy:reload_unicorn'
after 'deploy:reload_unicorn', 'deploy:stop_sidekiq'
after 'deploy:stop_sidekiq', 'deploy:start_sidekiq'

