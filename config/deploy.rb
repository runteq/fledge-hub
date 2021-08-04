# config valid for current version and patch releases of Capistrano
lock '~> 3.16.0'

set :application, 'fledge-hub'
set :repo_url, 'git@github.com:runteq/fledge-hub.git'
set :user, 'runteq'
set :deploy_to, '/var/www/fledge-hub'
set :linked_files, %w[config/master.key config/database.yml config/credentials/production.key]
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets public/system vendor/bundle]
set :rbenv_ruby, File.read('.ruby-version').strip
set :puma_threds, [4, 16]
set :puma_workers, 0
set :puma_bind, 'unix:///var/www/fledge-hub/shared/tmp/sockets/puma.sock'
set :puma_state, '/var/www/fledge-hub/shared/tmp/pids/puma.state'
set :puma_pid, '/var/www/fledge-hub/shared/tmp/pids/puma.pid'
set :puma_access_log, '/var/www/fledge-hub/shared/log/puma.error.log'
set :puma_error_log, '/var/www/fledge-hub/shared/log/puma.access.log'
set :puma_preload_app, true

# Default branch is :main
set :branch, ENV['BRANCH'] || 'main'

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute 'mkdir /var/www/fledge-hub/shared/tmp/sockets -p'
      execute 'mkdir /var/www/fledge-hub/shared/tmp/pids -p'
    end
  end

  # before :start, :make_dirs
end

namespace :deploy do
  desc 'upload important files'
  task :upload do
    on roles(:app) do
      sudo :mkdir, '-p', '/var/www/fledge-hub/shared/config/credentials'
      sudo %(chown -R #{fetch(:user)}.#{fetch(:user)} /var/www/#{fetch(:application)})
      sudo :mkdir, '-p', '/etc/nginx/sites-enabled'
      sudo :mkdir, '-p', '/etc/nginx/sites-available'

      upload!('config/database.yml', '/var/www/fledge-hub/shared/config/database.yml')
      upload!('config/master.key', '/var/www/fledge-hub/shared/config/master.key')
      upload!('config/credentials/production.key',
              '/var/www/fledge-hub/shared/config/credentials/production.key')
    end
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do
      with rails_env: fetch(:rails_env) do
        within release_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  before :starting, :upload
  before 'check:linked_files', 'puma:nginx_config'
end

after 'deploy:published', 'nginx:restart'
before 'deploy:migrate', 'deploy:db_create'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
