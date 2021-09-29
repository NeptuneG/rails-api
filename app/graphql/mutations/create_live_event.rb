# frozen_string_literal: true

module Mutations
  class CreateLiveEvent < GraphQL::Schema::Mutation
    null true
    argument :live_event, Types::LiveEventInputType, required: true

    def resolve(live_event:)
      LiveEvent.create(live_event.to_h)
    end
  end
end
