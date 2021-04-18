# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::GenresController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/genres').to route_to('api/v1/genres#index')
    end
  end
end
