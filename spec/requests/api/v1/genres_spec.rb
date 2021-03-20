# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/genres', type: :request do
  let_it_be(:valid_attributes) { { name: 'anime' } }
  let_it_be(:invalid_attributes) { { name: nil } }
  let_it_be(:valid_headers) { {} }
  let_it_be(:genre) { Genre.create!(valid_attributes) }

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_v1_genres_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_v1_genre_url(genre), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    subject(:create_a_genre) do
      post api_v1_genres_url, params: { genre: attributes }, headers: valid_headers, as: :json
    end

    context 'with valid parameters' do
      let(:attributes) { valid_attributes }

      it 'creates a new Genre' do
        expect { create_a_genre }.to change(Genre, :count).by(1)
      end

      it 'renders a JSON response with the new genre' do
        create_a_genre
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      let(:attributes) { invalid_attributes }

      it 'does not create a new Genre' do
        expect { create_a_genre }.to change(Genre, :count).by(0)
      end

      it 'renders a JSON response with errors for the new genre' do
        create_a_genre
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    subject(:update_a_genre) do
      patch api_v1_genre_url(genre), params: { genre: new_attributes }, headers: valid_headers, as: :json
    end

    context 'with valid parameters' do
      let(:new_attributes) { { name: 'comic' } }

      it 'updates the requested genre' do
        update_a_genre
        expect(genre.reload.name).to eq 'comic'
      end

      it 'renders a JSON response with the genre' do
        update_a_genre
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      let(:new_attributes) { { name: nil } }

      it 'renders a JSON response with errors for the genre' do
        update_a_genre
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested genre' do
      expect { delete api_v1_genre_url(genre), headers: valid_headers, as: :json }
        .to change(Genre, :count).by(-1)
    end
  end
end
