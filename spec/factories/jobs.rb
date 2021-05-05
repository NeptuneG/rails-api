# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    sequence(:jid) { |n| "#{Faker::Number.hexadecimal(digits: 16)}-#{n}" }

    type { 'live_events_scraping' }
    status { 'working' }
    args { '["202011"]' }
    error_message { nil }
    created_at { '2021-04-25 19:45:58' }
    updated_at { '2021-04-25 19:45:58' }
    enqueued_at { '2021-04-25 19:45:58' }
  end
end
