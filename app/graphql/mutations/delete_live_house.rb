# frozen_string_literal: true

module Mutations
  class DeleteLiveHouse < GraphQL::Schema::Mutation
    argument :id, ID, required: true

    def resolve(id:)
      LiveHouse.find(id).destroy
      true
    end
  end
end
