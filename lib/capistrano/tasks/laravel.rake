namespace :laravel do
    desc "Run Laravel Artisan migrate task."
    task :migrate do
        on roles(:laravel) do
            within release_path do
                execute :php, "artisan migrate --force"
            end
        end
    end

    desc "Run Laravel Artisan migrate:rollback task."
    task :migrate_rollback do
        on roles(:laravel) do
            within release_path do
                execute :php, "artisan migrate:rollback"
            end
        end
    end

    desc "Run Laravel Artisan seed task."
    task :seed do
        on roles(:laravel) do
            within release_path do
            end
        end
    end

    desc "Run Laravel Artisan seed task."
    task :seed do
        on roles(:laravel) do
            within release_path do
                fetch(:seeders).split(",").each do |seed|
                    execute :php, "artisan db:seed --class=#{seed}"
                end
            end
        end
    end

    desc "Optimize Laravel Class Loader"
    task :optimize do
        on roles(:laravel) do
            within release_path do
                execute :php, "artisan optimize:clear"
            end
        end
    end

    task :set_variables do
        on roles(:laravel) do
            puts ("--> Copying environment configuration file")
            execute "cp #{release_path}/.env.server #{release_path}/.env"
            puts ("--> Setting environment variables")
            execute "sed --in-place -f #{fetch(:overlay_path)}/parameters.sed #{release_path}/.env"
        end
    end

    task :fix_permission do
        on roles(:laravel) do
            execute :chown, "-R deploy:deploy #{release_path}/storage #{release_path}/bootstrap/cache"
        end
    end
    
    desc "Link storage"
    task :link_storage do
        on roles(:laravel) do
            within release_path do
                execute :php, "artisan storage:link"
            end
        end
    end

    desc "Restart queue"
    task :restart_queue do
        on roles(:laravel) do
            within release_path do
                execute :php, "artisan queue:restart"
            end
        end
    end

    task :configure_env do
        dotenv_file = fetch(:dotenv_file)
        on roles (:laravel) do
            execute :cp, "#{dotenv_file} #{release_path}/.env"
            execute "echo APP_VERSION=#{fetch(:current_revision)} >> #{release_path}/.env"
            execute "echo APP_VERSION=#{fetch(:current_revision)} >> #{release_path}/.env"
        end
    end
end
