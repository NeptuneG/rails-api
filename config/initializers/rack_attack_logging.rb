# frozen_string_literal: true

ActiveSupport::Notifications.subscribe(/rack_attack/) do |_name, _start, _finish, _request_id, payload|
  req = payload[:request]

  next unless req.env['rack.attack.match_type'] == :throttle

  Rails.logger.info("Rate limit hit throttle: #{req.ip} #{req.request_method} #{req.fullpath}")
end
