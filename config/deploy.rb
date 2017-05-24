lock "3.8.0"

set :application, "coursemate"
set :repo_url, "git@github.com:coursemate/coursemate.git"
set :user, "ahmad"
set :conditionally_migrate, true
set :assets_roles, [:all]
set :deploy_to, "/var/www/coursemate/"
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

after 'deploy:symlink:release', 'deploy:reload_unicorn'
