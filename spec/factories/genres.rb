# frozen_string_literal: true

FactoryBot.define do
  factory :genre do
    sequence(:id)
    sequence(:name) { |n| "#{Faker::Music.genre}-#{n}" }
  end
end
