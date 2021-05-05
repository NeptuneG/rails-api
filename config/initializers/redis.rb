# frozen_string_literal: true

Redis.current = Redis.new(host: ENV.fetch('REDIS_HOST', 'redis'))
