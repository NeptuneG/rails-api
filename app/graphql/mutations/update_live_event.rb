# frozen_string_literal: true

module Mutations
  class UpdateLiveEvent < GraphQL::Schema::Mutation
    null true
    argument :live_event, Types::LiveEventInputType, required: true

    def resolve(live_event:)
      LiveEvent.find(live_event[:id]).update(live_event.to_h)
    end
  end
end
