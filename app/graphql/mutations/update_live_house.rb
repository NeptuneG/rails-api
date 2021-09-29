# frozen_string_literal: true

module Mutations
  class UpdateLiveHouse < GraphQL::Schema::Mutation
    null false
    argument :live_house, Types::LiveHouseInputType, required: true

    def resolve(live_house:)
      LiveHouse.find(live_house[:id]).update(live_house.to_h)
    end
  end
end
