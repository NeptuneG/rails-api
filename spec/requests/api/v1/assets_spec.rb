# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/assets', type: :request do
  let(:database) { 'rails_api_test' }

  let_it_be(:genre) { Genre.create!(name: 'test') }

  let_it_be(:valid_attributes) { { genre_id: genre.id, title: 'Long Vacation' } }
  let_it_be(:invalid_attributes) { { genre_id: nil, title: 'Long Vacation' } }
  let_it_be(:valid_headers) { {} }

  let_it_be(:asset) { Asset.create!(valid_attributes) }

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_v1_assets_url(database: database), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_v1_asset_url(asset, database: database), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    subject(:create_an_asset) do
      post(api_v1_assets_url(database: database),
           params: { asset: attributes }, headers: valid_headers, as: :json)
    end

    context 'with valid parameters' do
      let(:attributes) { valid_attributes }

      it 'creates a new Asset' do
        expect { create_an_asset }.to change(Asset, :count).by(1)
      end

      it 'renders a JSON response with the new asset' do
        create_an_asset
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      let(:attributes) { invalid_attributes }

      it 'does not create a new Asset' do
        expect { create_an_asset }.to change(Asset, :count).by(0)
      end

      it 'renders a JSON response with errors for the new asset' do
        create_an_asset
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    subject(:update_an_asset) do
      patch(api_v1_asset_url(asset, database: database),
            params: { asset: new_attributes }, headers: valid_headers, as: :json)
    end

    context 'with valid parameters' do
      let(:new_attributes) { { title: 'HERO' } }

      it 'updates the requested asset' do
        update_an_asset
        expect(asset.reload.title).to eq 'HERO'
      end

      it 'renders a JSON response with the asset' do
        update_an_asset
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      let(:new_attributes) { { genre_id: nil } }

      it 'renders a JSON response with errors for the asset' do
        update_an_asset
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested asset' do
      expect do
        delete(api_v1_asset_url(asset, database: database),
               headers: valid_headers, as: :json)
      end.to change(Asset, :count).by(-1)
    end
  end
end
