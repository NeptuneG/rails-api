# frozen_string_literal: true

FactoryBot.define do
  factory :album do
    sequence(:id)
    title { Faker::Music.album }
    description { Faker::Movie.quote }

    association :genre
  end
end
