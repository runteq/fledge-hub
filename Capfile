require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rails'
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/migrations'
require 'capistrano/rails/assets'
require 'capistrano/yarn'
require 'capistrano/scm/git'
require 'capistrano/puma'
require 'capistrano/nginx'
require 'seed-fu/capistrano3'

install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Nginx
install_plugin Capistrano::Puma::Systemd

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
