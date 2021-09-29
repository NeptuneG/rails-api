# frozen_string_literal: true

module Types
  class LiveEventInputType < BaseInputObject
    description 'The attributes for creating a live event'

    argument :id, ID, required: false
    argument :title, String, required: true
    argument :url, String, required: true
    argument :description, String, required: false
    argument :price_info, String, required: false
    argument :stage_one_open_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :stage_one_start_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :stage_two_open_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :stage_two_start_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :live_house_id, ID, required: true
  end
end
