require "bundler/capistrano"

server "198.58.101.242", :web, :app, :db, primary: true

set :application, "wedding"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :use_sudo, false
set :keep_releases, 4

set :scm, "git"
# set :repository, "."
set :deploy_via, :copy


# set :deploy_via, :remote_cache
set :repository,  "git@github.com:mitchnick/wedding.git"
set :branch, "master"
set :shared_children, shared_children + %w{public/uploads}

require "bundler/capistrano"
set :default_environment, {
'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

default_run_options[:pty] = true
set :ssh_options, { :forward_agent => true }

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "sh /etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"

    run "mkdir -p #{shared_path}/config"

    # custom my mitch
    run "mkdir -p #{release_path}/config"
    # run ">#{release_path}/config/application.yml"
    # This was removed because it said no longer a file was needed to be created
    run "ln -s #{shared_path}/config/application.yml #{release_path}/config/application.yml"

    put File.read("config/database.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  before 'deploy:assets:precompile' do
    run "ln -s #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end

  task :copy_old_sitemap do
    run "if [ -e #{previous_release}/public/sitemap.xml.gz ]; then cp #{previous_release}/public/sitemap* #{current_release}/public/; fi"
  end

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end