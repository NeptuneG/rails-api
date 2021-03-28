# frozen_string_literal: true

FactoryBot.define do
  factory :genre do
    sequence(:id)
    name { Faker::Music::Hiphop.subgenres }
  end
end
