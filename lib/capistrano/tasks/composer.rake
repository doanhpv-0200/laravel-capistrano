namespace :composer do
    desc 'Copy vendor directory from last release'
    task :vendor_copy do
        on roles(:laravel) do
            puts ("--> Copy vendor folder from previous release")
            execute "vendorDir=#{current_path}/vendor; if [ -d $vendorDir ] || [ -h $vendorDir ]; then cp -a $vendorDir #{release_path}/vendor; fi;"
        end
    end
    desc "Running Composer Install"
    task :install do
        on roles(:laravel) do
            within release_path do
                execute :composer, "install --no-dev --quiet --prefer-dist --optimize-autoloader"
            end
        end
    end
    desc "Running Composer Update"
    task :update do
        on roles(:laravel) do
            within release_path do
                execute :composer, "update"
            end
        end
    end
end