worker_processes 2
stderr_path File.expand_path('unicorn.log', File.dirname(__FILE__) + '/../log')
stdout_path File.expand_path('unicorn.log', File.dirname(__FILE__) + '/../log')


shared_path = "/var/www/sky_finance/shared/"
current_path = "/var/www/sky_finance/current"

# ソケット経由で通信する
# ここがcapistranoの設定と合致していないと失敗する
listen '/tmp/sockets/unicorn.sock'
pid '/tmp/pids/unicorn.pid'


# capistrano 用に RAILS_ROOT を指定
working_directory current_path

# ダウンタイムなくす
preload_app true

before_fork do |server, worker|
  ENV['BUNDLE_GEMFILE'] = File.expand_path('Gemfile', current_path)
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end

