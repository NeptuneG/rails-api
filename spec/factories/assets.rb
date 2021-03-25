# frozen_string_literal: true

FactoryBot.define do
  factory :asset do
    sequence(:id)
    title { Faker::Movie.title }
    description { Faker::Movie.quote }

    association :genre
  end
end
