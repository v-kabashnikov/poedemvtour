app_name = 'poedemvtur'

set :repo_url, "git@github.com:digitalshop24/#{app_name}.git"
set :application, app_name
application = app_name
set :rvm_type, :user
set :rvm_ruby_version, '2.3.0'
set :deploy_to, "/var/www/apps/#{app_name}"

lock '3.5.0'

namespace :git do
  desc 'Deploy'
  task :deploy do
    ask(:message, "Commit message?")
    run_locally do
      execute "git add -A"
      execute "git commit -m '#{fetch(:message)}'"
      execute "git push -u origin master"
    end
  end
end

namespace :server do
  rails_env = 'production'
  desc 'Start server'
  task :start do
    on roles(:all) do
      within current_path do
        execute "cd #{current_path}"
        execute :bundle, "exec unicorn_rails -c #{current_path}/config/unicorn.rb -E #{rails_env}"
      end
    end
  end

  desc "Initiate a rolling restart by telling Unicorn to start the new application code and kill the old process when done."
  task :restart do
    on roles(:all) do
      execute "kill -USR2 $(cat /var/www/apps/#{app_name}/run/unicorn.pid)"
    end
  end

  desc "Stop the application by killing the Unicorn process"
  task :stop do
    on roles(:all) do
      execute "kill $(cat #{deploy_to}/run/unicorn.pid)"
    end
  end
end

namespace :deploy do

  desc 'Setup'
  task :setup do
    on roles(:all) do
      execute "mkdir  #{shared_path}/config/"
      execute "mkdir  /var/www/apps/#{application}/run/"
      execute "mkdir  /var/www/apps/#{application}/log/"
      execute "mkdir  /var/www/apps/#{application}/socket/"
      execute "mkdir #{shared_path}/system"

      upload!('config/application.yml', "#{shared_path}/config/application.yml")

      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:create db:migrate db:seed sletat:sync"
        end
      end
    end
  end

  desc 'Create symlink'
  task :symlink do
    on roles(:all) do
      execute "ln -s #{shared_path}/system #{release_path}/public/system"
      execute "ln -s #{shared_path}/config/application.yml #{release_path}/config/application.yml"
      execute "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
  end

  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:restart'

  after :updating, 'deploy:symlink'

  before :setup, 'deploy:starting'
  before :setup, 'deploy:updating'
  before :setup, 'bundler:install'

  after 'git:deploy', 'deploy'
  after :deploy, 'server:restart'
end

namespace :sidekiq do
  desc "Start Sidekiq"
  task :start do
    on roles(:all) do
      within current_path do
        execute "cd #{current_path}"
        execute :bundle, "exec sidekiq -c 10 -e production -d -L /var/www/apps/poedemvtur/log/sidekiq.log -P /var/www/apps/poedemvtur/run/sidekiq.pid"
      end
    end
  end
  desc "Stop Sidekiq"
  task :stop do
    on roles(:all) do
      execute "kill `cat #{deploy_to}/run/sidekiq.pid` || true"
    end
  end
end

namespace :config do
  task :update do
    on roles(:all) do
      upload!('config/application.yml', "#{shared_path}/config/application.yml")
      execute "ln -s #{shared_path}/config/application.yml #{release_path}/config/application.yml"
    end
  end
end
