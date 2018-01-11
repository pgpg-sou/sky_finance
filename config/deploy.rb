lock '3.10.1'

set :application, 'sky_sample'
set :repo_url, 'https://pgpg-sou:re23fvuy@github.com/pgpg-sou/sky_finance.git'
set :deploy_to, '/var/www/sky_finance'

set :default_stage, "development"
set :scm, :git
set :scm_username, "pgpg-sou"
set :scm_passphrase, "re23fvuy"

set :ssh_options, { :forward_agent => true }
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache


set :rbenv_type, :use
set :rbenv_custom_path, '/usr/local/rbenv'

set :log_level, :debug
set :pty, true # sudo に必要
# Shared に入るものを指定
set :linked_files, %w{config/database.yml }
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets bundle public/system public/assets}
# Unicorn
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"
# 5回分のreleasesを保持する
set :keep_releases, 5

set :unicorn_config_path, "config/unicorn.rb"



after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  # アプリの再起動を行うタスク
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :mkdir, '-p', release_path.join('tmp')
      execute :touch, release_path.join('tmp/restart.txt')
      invoke 'unicorn:stop'
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
