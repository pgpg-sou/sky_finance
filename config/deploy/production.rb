server '18.221.114.170', user: 'deploy', roles: %w{app}

set :ssh_options, {
  port: 22,
  forward_agent: true,
  keys: ['~/.ssh/sky_finance_deploy.pem'],
}

set :deploy_target, 'app'
set :branch, :master



