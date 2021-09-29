# frozen_string_literal: true

module Types
  class LiveEventType < Types::BaseObject
    description 'A live event'

    field :id, ID, null: false
    field :title, String, null: false
    field :url, String, null: false
    field :description, String, null: true
    field :price_info, String, null: true
    field :stage_one_open_at, GraphQL::Types::ISO8601DateTime, null: true
    field :stage_one_start_at, GraphQL::Types::ISO8601DateTime, null: false
    field :stage_two_open_at, GraphQL::Types::ISO8601DateTime, null: true
    field :stage_two_start_at, GraphQL::Types::ISO8601DateTime, null: true
    field :live_house, Types::LiveHouseType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :errors, [Types::ErrorType], null: true

    def errors
      object.errors.to_hash.map do |field, messages|
        { field: field, messages: messages }
      end
    end
  end
end
