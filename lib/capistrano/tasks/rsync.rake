namespace :web do
    desc "Synchronize to worker server"
    task :synchronize_worker do
        on roles(:web) do
            fetch(:worker_servers).each do |host|
                puts("---> Synchronize #{release_path} to #{host}:#{current_path}")
                execute "ssh #{host} mkdir -p #{deploy_to}"
                execute "ssh #{host} mkdir -p #{current_path}"
                execute "rsync -rt #{release_path} deploy@#{host}:#{current_path}"
                execute "rsync -rt -0 #{shared_path}/storage/framework deploy@#{host}:#{current_path}/storage"
                execute "rsync -rt -0 #{release_path}/storage/app deploy@#{host}:#{current_path}/storage"
                execute "ssh #{host} rm -rf #{current_path}/storage/logs"
                execute "ssh #{host} mkdir -p #{current_path}/storage/logs"
                execute "ssh #{host} cp ~/.env.prod #{current_path}/.env"
                execute "ssh #{host} php #{current_path}/artisan optimize:clear"
            end
        end
    end

    desc "List all release"
    task :release_list do
        on roles(:laravel) do
            puts ("--> Release list:")
            within release_path do
                execute "ls #{fetch(:releases_dir)}"
            end
        end
    end
end
