# Change these
server '165.22.242.117', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:gareth-go/blog-website.git'
set :application,     'blog-website'

set :rbenv_ruby,      '2.7.8'
# set :rbenv_ruby_dir,  '/home/ubuntu/.rbenv/versions/3.0.2'
set :default_env, { path: '~/.rbenv/shims:~/.rbenv/bin:$PATH' }

# If using Digital Ocean's Ruby on Rails Marketplace framework, your username is 'rails'
set :user,            'deploy'
set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true # Change to false when not using ActiveRecord

append :rbenv_map_bins, 'puma', 'pumactl'

## Defaults:
# set :scm,           :git
set :branch, 'deploy/digital-ocean'
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
# set :linked_files, %w{config/database.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before 'deploy:starting', 'puma:make_dirs'
end

namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :check_revision do
    on roles(:app) do
      # Update this to your branch name: master, main, etc. Here it's main
      unless `git rev-parse HEAD` == `git rev-parse origin/deploy/digital-ocean`
        puts 'WARNING: HEAD is not the same as origin/deploy/digital-ocean'
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

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  # after  :finishing,    :restart
end

set :rvm_map_bins, %w[gem rake ruby rails bundle]

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
