# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'project_name'
set :repo_url, 'project_repo'

# Default branch is :master
ask :branch, 'master'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/project_name'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
set :rvm_type, :system

# Default value for keep_releases is 5
set :keep_releases, 2

set :templates_path, 'config/deploy/templates'

namespace :deploy do
  after :published, :clear_cache do
    invoke 'delayed_job:restart'
    invoke 'clockwork:restart'
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'swagger:docs'
        end
      end
    end
  end
end

namespace :delayed_job do 

  desc "Start the delayed_job process"
  task :start do
    on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :'bin/delayed_job', :"start"
        end
      end
    end
  end

  desc "Stop the delayed_job process"
  task :stop do
    on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :'bin/delayed_job', :"stop"
        end
      end
    end
  end

  desc "Restart the delayed_job process"
  task :restart do
    invoke 'delayed_job:stop'
    invoke 'delayed_job:start'
  end

end