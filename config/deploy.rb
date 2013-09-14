require 'rvm/capistrano'
require 'bundler/capistrano'

set :rvm_type, :system

set :application, "rabotazaden.com"
set :user, 'rabotlivko'
set :deploy_to, "/home/#{user}/apps/rabotazaden"
set :deploy_via, :remote_cache
set :use_sudo, false

default_run_options[:pty] = true

set :scm, :git
set :repository, 'git@github.com:hddimitrov/rabotlivko.git'
set :branch, 'master'

set :ssh_options, { :forward_agent => true }

set :rake, 'bundle exec rake'

# role :web, "rabotazaden.com"                          # Your HTTP server, Apache/etc
# role :app, "rabotazaden.com"                          # This may be the same as your `Web` server
# role :db,  "rabotazaden.com", :primary => true        # This is where Rails migrations will run
# # role :db,  "your slave db-server here"

server "212.71.254.218", :app, :web, :db, :primary => true

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"
after "deploy:update_code", "deploy:symlink_yml"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:

# after 'deploy:update_code' do
#   # upload 'config/initializers/mandrill.rb', "#{current_path}/config/initializers/mandrill.rb", via: :scp
# end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc 'create mandrill.yml synlink to config'
  task :symlink_yml do
    puts "creating symlink_yml"
    run "ln -sf #{shared_path}/config/mandrill.yml #{current_path}/config/mandrill.yml"
  end
end
