lock '3.8.2'

set :application, 'sjz'
set :repo_url, 'git@github.com:hungmi/sjz.git' # Edit this to match your repository
set :branch, :master
set :deploy_to, '/home/deploy/apps/sjz'
set :pty, false
set :linked_files, %w{config/database.yml config/application.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :bundle_binstubs, nil
set :keep_releases, 5
set :rvm_type, :user
set :rvm_ruby_version, 'ruby-2.4.1' # Edit this if you are using MRI Ruby

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 16]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, true

# Whenever is cron job scheduler
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :deploy do
	desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

	desc 'Upload YAML files.'
	task :upload_yml do
	  on roles(:app) do
	    execute "mkdir #{shared_path}/config -p"
	    upload! StringIO.new(File.read("config/database.yml")), "#{shared_path}/config/database.yml"
	    upload! StringIO.new(File.read("config/application.yml")), "#{shared_path}/config/application.yml"
	    upload! StringIO.new(File.read("config/secrets.yml")), "#{shared_path}/config/secrets.yml"
	  end
	end

	desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting, :upload_yml
  before :starting, :make_dirs
  after :finished, :restart
end