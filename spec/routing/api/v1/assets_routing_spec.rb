# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AssetsController, type: :routing do
  describe 'routing' do
    let(:db) { 'rails_api_test' }

    it 'routes to #index' do
      expect(get: "/api/v1/#{db}/assets").to route_to('api/v1/assets#index', database: db)
    end

    it 'routes to #show' do
      expect(get: "/api/v1/#{db}/assets/1").to route_to('api/v1/assets#show', database: db, id: '1')
    end

    it 'routes to #create' do
      expect(post: "/api/v1/#{db}/assets").to route_to('api/v1/assets#create', database: db)
    end

    it 'routes to #update via PUT' do
      expect(put: "/api/v1/#{db}/assets/1").to route_to('api/v1/assets#update', database: db, id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: "/api/v1/#{db}/assets/1").to route_to('api/v1/assets#update', database: db, id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: "/api/v1/#{db}/assets/1").to route_to('api/v1/assets#destroy', database: db, id: '1')
    end
  end
end
