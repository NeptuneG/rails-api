# frozen_string_literal: true

FactoryBot.define do
  factory :genre do
    sequence(:id)
    name { 'movie' }
  end
end
