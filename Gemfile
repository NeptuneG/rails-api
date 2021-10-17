# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.3.1'

gem 'activerecord-import', '~> 1.0.8'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'elasticsearch', '~> 7.0'
gem 'elasticsearch-model', '~> 7.0'
gem 'elasticsearch-rails', '~> 7.0'
gem 'friendly_id', '~> 5.4.2'
gem 'jbuilder', '~> 2.7'
gem 'metainspector', '~> 5.11.1'
gem 'parallel', '~> 1.20.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-attack'
gem 'redis', '~> 4.0'
gem 'redis-namespace', '~> 1.8.1'
gem 'rswag-api', '~> 2.4.0'
gem 'rswag-ui', '~> 2.4.0'
gem 'sidekiq', '~> 6.1.3'
gem "sidekiq-cron", "~> 1.1"
gem 'sidekiq-failures'
gem 'sidekiq_queue_metrics', '~> 3.0.0'
gem 'sidekiq-status', '~> 1.1.4'
gem 'sidekiq-throttled', '~> 0.13.0'

# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rswag-specs', '~> 2.4.0'
end

group :development do
  gem 'listen', '~> 3.3'

  gem 'rubocop'
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'webrick'
end

group :test do
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'test-prof'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
