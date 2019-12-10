# Define your own task in here
# namespace :app do
#     desc 'Update git logs into env'
#     task :update_git do
#         on roles(:laravel) do
#             puts ("--> Update git logs into env")
#             execute "echo APP_VERSION=#{fetch(:current_revision)} >> .env"
#             execute "echo GIT_BRANCH=#{fetch(:branch)} >> .env"
#         end
#     end
# end