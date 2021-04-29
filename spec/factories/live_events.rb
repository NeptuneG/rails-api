# frozen_string_literal: true

FactoryBot.define do
  factory :live_event do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    price_info { Faker::Lorem.sentence }
    sequence(:url) { |n| "#{Faker::Internet.url}/#{n}" }
    stage_one_open_at { '2021-04-25 19:45:58' }
    stage_one_start_at { '2021-04-25 19:45:58' }
    stage_two_open_at { '2021-04-25 19:45:58' }
    stage_two_start_at { '2021-04-25 19:45:58' }

    live_house
  end
end
