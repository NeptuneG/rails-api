# frozen_string_literal: true

require 'rails_helper'

describe '/api/v1/artists', type: :request do
  let(:valid_headers) { {} }

  describe 'GET /index' do
    it 'renders a successful response' do
      get(api_v1_artists_url, headers: valid_headers, as: :json)
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    let(:artist) { create(:artist) }

    it 'renders a successful response' do
      get api_v1_artist_url(artist), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    subject(:create_an_artist) do
      post(api_v1_artists_url, params: attributes, headers: valid_headers, as: :json)
    end

    context 'with valid parameters' do
      let(:attributes) { attributes_for(:artist) }

      it 'creates a new Artist' do
        expect { create_an_artist }.to change(Artist, :count).by(1)
      end

      it 'renders a JSON response with the new artist' do
        create_an_artist
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      let(:attributes) { { name: nil } }

      it 'does not create a new Artist' do
        expect { create_an_artist }.to change(Artist, :count).by(0)
      end

      it 'renders a JSON response with errors for the new artist' do
        create_an_artist
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    subject(:update_an_artist) do
      patch(api_v1_artist_url(artist), params: new_attributes, headers: valid_headers, as: :json)
    end

    let(:artist) { create(:artist) }

    context 'with valid parameters' do
      let(:new_attributes) { { name: 'comic' } }

      it 'updates the requested artist' do
        update_an_artist
        expect(artist.reload.name).to eq 'comic'
      end

      it 'renders a JSON response with the artist' do
        update_an_artist
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      let(:new_attributes) { { name: nil } }

      it 'renders a JSON response with errors for the artist' do
        update_an_artist
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    subject(:delete_an_artist) do
      delete(api_v1_artist_url(artist), headers: valid_headers, as: :json)
    end

    let(:artist) { create(:artist) }

    it 'destroys the requested artist' do
      expect { delete_an_artist }
        .to change { Artist.exists?(artist.id) }.from(true).to(false)
    end
  end
end
