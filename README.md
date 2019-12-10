## 1. Requirement
 - [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
 - gem capistrano

```bash
gem install capistrano
```

### SSH
We will deploy into 1 server (`web`) then sync code to other server (`worker`)
- Make sure your `local machine` or `deploy server` can ssh to server `web`
- Make sure your `web` server has access permission to `github repository`
- Make sure your `web` server can ssh to all `worker` server for running `rsync`

## 2. Configure
```sh
cp config/deploy.rb.example config/deploy.rb
cp config/deploy/staging.rb.example config/deploy/staging.rb
cp config/deploy/production.rb.example config/deploy/production.rb
```

#### 2.1. `config/deploy.rb`
```ruby
# Config application
set :application, "app_name"
set :repo_url, "git@github.com:YOUR_USER_NAME/REPOSITORY.git"

# Config for deploy path
set :deploy_to, '/var/www/test-deploy'
set :releases_dir, '/var/www/test-deploy/releases'

# Default env
set :dotenv_file, '/PATH/TO/.env'

# Default value for keep_releases is 5
set :keep_releases, 5

# List of worker servers
set :workers_servers, []

# Slack configure
set :slackistrano, {
   klass: Slackistrano::CustomMessaging,
   channel: '#your-channel',
   webhook: 'your-incoming-webhook-url'
}
```

#### 2.2. `config/deploy/production.rb`
```ruby
# server web detail
# You need to change ip and user for your server
server '10.0.0.10', user: 'deploy', roles: %w{web app laravel}

# Config ssh option
set :ssh_options, {
   keys: %w(LINK/TO/YOUR/private_key),
   forward_agent: false,
   auth_methods: %w(publickey)
}
```

## 3. Usage
#### 3.1. Deploy
```bash
# Deploy with tag 1.0.1
cap staging deploy branch=1.0.1

# Deploy with tag 1.0.2 and run Seeder_0_0_1 and Seeder_0_0_2
cap staging deploy branch=1.0.2 seeders=Seeder_0_0_1,Seeder_0_0_2

# Rollback deploy
cap staging rollback

# Rollback deploy to specific release
cap staging rollback ROLLBACK_RELEASE=20191001101213
```

#### 3.2. Run single task
You can run any task as a single task

```bash
# Rollback migrate
cap staging laravel:migrate_rollback

# List all release (for rollback release above)
cap staging web:release_list
```

