# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
gem 'redis-namespace'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

gem 'rswag-api'
gem 'rswag-ui'

gem 'friendly_id', '~> 5.4.0'

# Sidekiq
gem 'sidekiq', '~> 6.1.2'
gem 'sidekiq-batch', '~> 0.1.6'
gem 'sidekiq_queue_metrics', '~> 3.0.0'
gem 'sidekiq-status', '~> 1.1.4'
gem 'sidekiq-throttled', '~> 0.13.0'

# Elastic Search
gem 'elasticsearch', '~> 7.0'
gem 'elasticsearch-model', '~> 7.0'
gem 'elasticsearch-rails', '~> 7.0'

gem 'rack-attack'

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
end

group :development do
  gem 'listen', '~> 3.3'

  gem 'rubocop'
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rswag-specs'
  gem 'shoulda-matchers'
  gem 'test-prof'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
