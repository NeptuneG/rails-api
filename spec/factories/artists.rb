# frozen_string_literal: true

FactoryBot.define do
  factory :artist do
    sequence(:id)
    name { Faker::Music.band }
  end
end
