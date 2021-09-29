# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :live_houses, [Types::LiveHouseType],
          null: true, description: 'All live house'
    def live_houses
      LiveHouse.all
    end

    field :live_house, Types::LiveHouseType,
          null: true, description: 'One live house' do
      argument :id, ID, required: true
    end
    def live_house(id:)
      LiveHouse.find_by(id: id)
    end

    field :live_event, Types::LiveEventType,
          null: true, description: 'One live event' do
      argument :id, ID, required: true
    end
    def live_event(id:)
      LiveEvent.find_by(id: id)
    end

    field :live_events, [Types::LiveEventType],
          null: true, description: 'All live events'
    def live_events
      LiveEvent.all
    end
  end
end
