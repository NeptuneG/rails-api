# frozen_string_literal: true

FactoryBot.define do
  factory :live_house do
    sequence(:name) { |n| "Live House - #{n}" }
    address { 'MyString' }

    trait :bbl_tokyo do
      name { 'Billboard Live TOKYO' }
      address { '@Midtown, Roppongi, Tokyo' }
    end
  end
end
