# config valid for current version and patch releases of Capistrano
#lock "~> 3.10.1"

#set :application, "my_app_name"
#set :repo_url, "git@example.com:me/my_repo.git"

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
# append :linked_files, "config/database.yml", "config/secrets.yml"

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
#
#
#
#require 'rvm/capistrano'
lock '3.2.1'

set :application, 'sky_sample'
set :repo_url, 'git@github.com:pgpg-sou/sky_finance.git'
set :deploy_to, '/var/www/sky_finance'

set :default_stage, "development"
set :scm, :git
set :deploy_via, :remote_cache

set :log_level, :debug
set :pty, true # sudo に必要
# Shared に入るものを指定
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets bundle public/system public/assets}
# RVM
set :rvm_type, :system
set :rvm1_ruby_version, '2.1'
# Unicorn
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"
# 5回分のreleasesを保持する
set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  # アプリの再起動を行うタスク
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :mkdir, '-p', release_path.join('tmp')
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  # linked_files で使用するファイルをアップロードするタスク
  # deployが行われる前に実行する必要がある。
  desc 'upload important files'
  task :upload do
    on roles(:app) do |host|
      execute :mkdir, '-p', "#{shared_path}/config"
      upload!('config/database.yml',"#{shared_path}/config/database.yml")
      upload!('config/secrets.yml',"#{shared_path}/config/secrets.yml")
    end
  end

  # webサーバー再起動時にキャッシュを削除する
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
        execute :rm, '-rf', release_path.join('tmp/cache')
      end
    end
  end

  # Flow の before, after のタイミングで上記タスクを実行
  before :started, 'deploy:upload'
  after :finishing, 'deploy:cleanup'

  # Unicorn 再起動タスク
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart' # lib/capustrano/tasks/unicorn.cap 内処理を実行
  end
end
