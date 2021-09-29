# frozen_string_literal: true

module Types
  class LiveHouseInputType < BaseInputObject
    description 'The attributes for creating a live house'

    argument :id, ID, required: false
    argument :name, String, required: true
    argument :address, String, required: false
  end
end
