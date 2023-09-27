source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"
gem "rails", "7.0.5"
gem "sprockets-rails"
gem "mysql2", "~> 0.5"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "redis", "~> 4.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "devise"
gem "foreman"
gem "sassc-rails"
gem "font-awesome-sass"
gem "tailwindcss-rails"
gem "sidekiq"
gem "cancancan"
gem "rolify"
gem "rack-cors"
gem "kaminari"
gem "creek"
gem "dotenv-rails"

group :development, :test do
  gem "pry"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "web-console"
  gem "capistrano"
  gem "capistrano3-puma"
  gem "capistrano-rails", require: false
  gem "capistrano-bundler", require: false
  gem 'capistrano-asdf'
  gem 'capistrano-sidekiq'
end
