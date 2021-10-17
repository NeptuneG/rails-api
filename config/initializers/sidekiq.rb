# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq-status'
require 'sidekiq/throttled'
require 'sidekiq_queue_metrics'

Sidekiq::Throttled.setup!

configuration = {
  url: "redis://#{ENV.fetch('REDIS_CACHE_HOST', 'redis')}:#{ENV.fetch('REDIS_CACHE_PORT', 6379)}",
  password: ENV['REDIS_CACHE_PASSWORD'],
  namespace: 'sidekiq'
}

expiration = 1.day

Sidekiq.configure_server do |config|
  config.redis = configuration

  Sidekiq::Status.configure_server_middleware config, expiration: expiration
  Sidekiq::Status.configure_client_middleware config, expiration: expiration

  Sidekiq::QueueMetrics.init(config)
end

Sidekiq.configure_client do |config|
  config.redis = configuration

  Sidekiq::Status.configure_client_middleware config, expiration: expiration
end
