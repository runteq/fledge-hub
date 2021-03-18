source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.3'

gem 'bootsnap', require: false
gem 'mysql2'
gem 'puma'
gem 'sass-rails'
gem 'turbolinks'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'webpacker'

gem 'rails-i18n'
gem 'slim-rails'
gem 'sorcery'

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
  gem 'capybara'
  gem 'rspec_junit_formatter'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
