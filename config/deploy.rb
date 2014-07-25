require "bundler/capistrano"
require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.3'
set :rvm_type, :user
set :application, "state.io"
set :repository,  "git@github.com:stateio/state.io.git"
set :use_sudo, false
set :scm, :git
ssh_options[:forward_agent] = true
default_run_options[:pty] = true
set :branch, ENV['BRANCH'] || 'master'

set :user, "deploy"
role :web, "okayfail.com"

namespace :deploy do
  task :bundle do
    run "cd #{current_path} && bundle install"
  end
  task :run_md do
    run "cd #{current_path} && bundle exec middleman build"
  end
end

after "deploy:restart", "deploy:run_md"
