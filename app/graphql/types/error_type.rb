# frozen_string_literal: true

module Types
  class ErrorType < Types::BaseObject
    description 'An ActiveRecord error'

    field :field, String, null: false, camelize: false
    field :messages, [String], null: false
  end
end
