source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'rails', '~> 6.1.3'

gem 'bootsnap', require: false
gem 'mysql2'
gem 'puma'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'webpacker'
gem 'sprockets', '~> 3.7.2' # 4.0だとassetsがないときにエラーが発生するため

gem 'mini_magick', '>= 4.9.5'
gem 'image_processing'
gem 'active_hash'
gem 'rails-i18n'
gem 'seed-fu'
gem 'tailwindcss-rails'
gem 'hotwire-rails'
gem 'slim-rails'
gem 'view_component'
gem 'ransack'
gem 'active_decorator'
gem 'sorcery'
gem 'pagy'
gem 'config'
gem 'mechanize'
gem 'meta-tags'
# https://github.com/smartinez87/exception_notification/issues/503 リリースされていないため
gem 'exception_notification', github: 'smartinez87/exception_notification'
gem 'httparty'
gem 'rambulance'

# 外部サービス
gem 'faraday'
gem 'faraday_middleware' # Oauthのため
gem 'simple_oauth'

# バリデーション
gem 'valid_email2'
gem 'date_validator'
gem 'validate_url'
gem 'active_storage_validations'
gem 'recaptcha'

# AWS
gem 'aws-sdk-s3', require: false

group :development, :test do
  gem 'bullet'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'pry-rails'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman'
  gem 'bcrypt_pbkdf'
  gem 'capistrano'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano3-puma'
  gem 'capistrano-nginx'
  gem 'capistrano-yarn'
  gem 'ed25519'
  gem 'listen'
  gem 'rack-mini-profiler'
  gem 'rails_best_practices'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
  gem 'web-console'
end

group :test do
  gem 'active_decorator-rspec'
  gem 'capybara'
  gem 'rspec_junit_formatter'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
