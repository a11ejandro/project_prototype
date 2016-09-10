role :app, %w{develop_server_address}
role :web, %w{develop_server_address}
role :db, %w{develop_server_address}
role :worker, %w{develop_server_address}

set :rails_env, 'develop'
ask :branch, 'develop'

set :rvm_type, :user

set :ssh_options, {
                    user: 'ubuntu',
                    keys: %w(project_name.pem),
                    forward_agent: false,
                    auth_methods: %w(publickey)
                }

#NGINX
set :templates_path, 'config/deploy/templates'
set :nginx_config_name, 'nginx_project_name.conf'
set :nginx_server_name, 'develop_server_address'
set :nginx_pid, '/run/nginx.pid'
set :nginx_use_ssl, false
set :nginx_config_path, '/etc/nginx/conf.d'

set :unicorn_workers, 2
set :unicorn_user, 'ubuntu'
set :unicorn_log, "#{shared_path}/log/unicorn.log"
set :unicorn_config, "#{shared_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"
set :unicorn_sock, "#{shared_path}/tmp/sockets/unicorn.sock"