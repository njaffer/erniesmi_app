set :application, "ErniesMichigan"
set :repo_url, "https://github.com/njaffer/erniesmi_app"

# Default branch is :master
set :branch, 'master'

# Default deploy_to directory is /var/www/my_app_name
 set :deploy_to, '~/app/'

 set :rails_env, :development
set :puma_threads, [4, 16]
# Don’t change these unless you know what you’re doing
set :pty, true
set :use_sudo, false
set :stage, :production
set :deploy_via, :remote_cache
set :puma_bind, “unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock”
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log, "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, false

set :deploy_to, "/home/ubuntu/ErniesMichigan/"

namespace :puma do
 desc 'Create Directories for Puma Pids and Socket'
 task :make_dirs do
 on roles(:app) do
 execute 'mkdir #{shared_path}/tmp/sockets -p'
 execute 'mkdir #{shared_path}/tmp/pids -p'
 end
 end
#before :start, :make_dirs
end

namespace :deploy do
 desc 'Make sure local git is in sync with remote.'
 task :check_revision do
 on roles(:app) do
 unless `git rev-parse HEAD` == `git rev-parse origin/master`
 puts 'WARNING: HEAD is not the same as origin/master'
 puts 'Run `git push` to sync changes.'
 exit
 end
 end
 end
desc 'Initial Deploy'
task :initial do
 on roles(:app) do
 before 'deploy:restart', 'puma:start'
 invoke 'deploy'
 end
 end
desc 'Restart application'
task :restart do
 on roles(:app), in: :sequence, wait: 5 do
 invoke 'puma:restart'
 end
 end
before :starting, :check_revision
 after :finishing, :compile_assets
 after :finishing, :cleanup
 after :finishing, :restart
end

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/spree', 'public/assets')
# set :linked_dirs, fetch(:linked_dirs, [])

set :rvm_ruby_version, '2.7.2'

# Default value for default_env is {}
# set :default_env, { rails_env: "development" }
set :default_environment, {
  'PATH' => "$PATH",
  'RUBY_VERSION' => 'ruby-2.7.0',
  'GEM_HOME' => '/home/ubuntu/.rvm/gems/ruby-2.7.0',
  'GEM_PATH' => '/home/ubuntu/.rvm/gems/ruby-2.7.0:/home/ubuntu/.rvm/gems/ruby-2.7.0@global',
  'PASSENGER_INSTANCE_REGISTRY_DIR' => '/home/ubuntu/passenger_temp'
}
# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 2

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :migration_role, :web
set :migration_command, 'db:migrate'
set :conditionally_migrate, true

append :linked_files, "config/master.key"

# namespace :deploy do
#   after "bundler:install", "assets:precompile"
# end

# namespace :assets do
#   desc "Precompile assets locally and then rsync to web servers"
#   task :precompile do
#     on roles(:app) do
#       rsync_host = host.to_s # this needs to be done outside run_locally in order for host to exist
#       run_locally do
#         with rails_env: fetch(:stage) do
#           execute :bundle, "exec rake assets:precompile"
#         end
#         execute "rsync -av public/assets/ ubuntu@ec2-18-237-189-231.us-west-2.compute.amazonaws.com:#{current_path}/public/assets/"
#         execute "rm -rf public/assets"
#         execute "rm -rf tmp/cache/assets" # in case you are not seeing changes
#       end
#     end
#   end
# end

#namespace :deploy do
#  namespace :check do
#    before :linked_files, :set_master_key do
#      on roles(:web), in: :sequence, wait: 10 do
#        unless test("[ -f #{shared_path}/config/master.key ]")
#          upload! 'config/master.key', "#{shared_path}/config/master.key"
#        end
#      end
#    end
#  end
#end

after 'deploy:updated', :updated_cache do 
  on roles(:app) do
     execute :chmod, "-R 777 #{fetch(:deploy_to)}/current/#{fetch(:cache_path)}"
  end
end
