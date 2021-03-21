# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::GenresController, type: :routing do
  describe 'routing' do
    let(:db) { 'rails_api_test' }

    it 'routes to #index' do
      expect(get: "/api/v1/#{db}/genres").to route_to('api/v1/genres#index', database: db)
    end

    it 'routes to #show' do
      expect(get: "/api/v1/#{db}/genres/1").to route_to('api/v1/genres#show', database: db, id: '1')
    end

    it 'routes to #create' do
      expect(post: "/api/v1/#{db}/genres").to route_to('api/v1/genres#create', database: db)
    end

    it 'routes to #update via PUT' do
      expect(put: "/api/v1/#{db}/genres/1").to route_to('api/v1/genres#update', database: db, id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: "/api/v1/#{db}/genres/1").to route_to('api/v1/genres#update', database: db, id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: "/api/v1/#{db}/genres/1").to route_to('api/v1/genres#destroy', database: db, id: '1')
    end
  end
end
