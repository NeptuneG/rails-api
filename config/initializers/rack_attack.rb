# frozen_string_literal: true

module Rack
  class Attack
    class Request
      def api_request?
        path.start_with?('/api')
      end

      def remote_ip
        @remote_ip ||= (@env['action_dispatch.remote_ip'] || ip).to_s
      end
    end

    throttle('requests by ip', limit: 50, period: 30.seconds) do |req|
      req.remote_ip if req.api_request?
    end

    self.throttled_response = lambda do |env|
      now        = Time.zone.now
      match_data = env['rack.attack.match_data']

      headers = {
        'Content-Type' => 'application/json',
        'X-RateLimit-Limit' => match_data[:limit].to_s,
        'X-RateLimit-Remaining' => '0',
        'X-RateLimit-Reset' => (now + (match_data[:period] - now.to_i % match_data[:period])).iso8601
      }

      [429, headers, [{ code: 8001, error_msg: 'Too many requests. Please retry later.' }.to_json]]
    end
  end
end
