namespace :npm do
    desc "Running npm Install"
    task :install do
        on roles(:laravel) do
            within release_path do
                execute :yarn, "install"
            end
        end
    end
    desc 'Copy node_modules directory from last release'
    task :npm_copy do
        on roles(:laravel) do
            puts ("--> Copy node_modules folder from previous release")
            execute "nodeModuleDir=#{current_path}/node_modules; if [ -d $nodeModuleDir ] || [ -h $nodeModuleDir ]; then cp -a $nodeModuleDir #{release_path}/node_modules; fi;"
        end
    end
    desc "Running npm run prod"
    task :run_prod do
        on roles(:laravel) do
            within release_path do
                execute :npm, "run prod"
            end
        end
    end
    desc "Running npm run dev"
    task :run_dev do
        on roles(:laravel) do
            within release_path do
                execute :npm, "run dev"
            end
        end
end