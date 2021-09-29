# frozen_string_literal: true

module Mutations
  class CreateLiveHouse < GraphQL::Schema::Mutation
    null true
    argument :live_house, Types::LiveHouseInputType, required: true

    def resolve(live_house:)
      LiveHouse.create(live_house.to_h)
    end
  end
end
