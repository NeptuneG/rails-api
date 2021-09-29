# frozen_string_literal: true

module Mutations
  class DeleteLiveEvent < GraphQL::Schema::Mutation
    argument :id, ID, required: true

    def resolve(id:)
      LiveEvent.find(id).destroy
      true
    end
  end
end
