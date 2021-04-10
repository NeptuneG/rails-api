# frozen_string_literal: true

FactoryBot.define do
  factory :album do
    sequence(:id)
    title { Faker::Music.album }
    description { Faker::Movie.quote }
    release_year { Faker::Vehicle.year }

    association :genre
    association :artist
  end
end
