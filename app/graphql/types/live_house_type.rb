# frozen_string_literal: true

module Types
  class LiveHouseType < Types::BaseObject
    description 'A live house'

    field :id, ID, null: false
    field :name, String, null: false
    field :address, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :live_events, [Types::LiveEventType], null: true

    field :errors, [Types::ErrorType], null: true

    def errors
      object.errors.to_hash.map do |field, messages|
        { field: field, messages: messages }
      end
    end
  end
end
