# frozen_string_literal: true

module Types
  class MutationType < BaseObject
    field :create_live_house, LiveHouseType, mutation: Mutations::CreateLiveHouse
    field :update_live_house, GraphQL::Types::Boolean, mutation: Mutations::UpdateLiveHouse
    field :delete_live_house, GraphQL::Types::ID, mutation: Mutations::DeleteLiveHouse

    field :create_live_event, LiveEventType, mutation: Mutations::CreateLiveEvent
    field :update_live_event, GraphQL::Types::Boolean, mutation: Mutations::UpdateLiveEvent
    field :delete_live_event, GraphQL::Types::ID, mutation: Mutations::DeleteLiveEvent
  end
end
