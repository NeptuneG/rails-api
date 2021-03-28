# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/albums', type: :request do
  let_it_be(:genre) { create(:genre) }
  let_it_be(:artist) { create(:artist) }

  let_it_be(:valid_attributes) do
    { artist_id: artist.id, genre_id: genre.id, title: 'Long Vacation' }
  end
  let_it_be(:invalid_attributes) { { genre_id: nil, title: 'Long Vacation' } }
  let_it_be(:valid_headers) { {} }

  let_it_be(:album) { Album.create!(valid_attributes) }

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_v1_albums_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_v1_album_url(album), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    subject(:create_an_album) do
      post(api_v1_albums_url,
           params: { album: attributes }, headers: valid_headers, as: :json)
    end

    context 'with valid parameters' do
      let(:attributes) { valid_attributes }

      it 'creates a new album' do
        expect { create_an_album }.to change(Album, :count).by(1)
      end

      it 'renders a JSON response with the new album' do
        create_an_album
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      let(:attributes) { invalid_attributes }

      it 'does not create a new album' do
        expect { create_an_album }.to change(Album, :count).by(0)
      end

      it 'renders a JSON response with errors for the new album' do
        create_an_album
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    subject(:update_an_album) do
      patch(api_v1_album_url(album),
            params: { album: new_attributes }, headers: valid_headers, as: :json)
    end

    context 'with valid parameters' do
      let(:new_attributes) { { title: 'HERO' } }

      it 'updates the requested album' do
        update_an_album
        expect(album.reload.title).to eq 'HERO'
      end

      it 'renders a JSON response with the album' do
        update_an_album
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      let(:new_attributes) { { genre_id: nil } }

      it 'renders a JSON response with errors for the album' do
        update_an_album
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested album' do
      expect do
        delete(api_v1_album_url(album),
               headers: valid_headers, as: :json)
      end.to change(Album, :count).by(-1)
    end
  end
end
