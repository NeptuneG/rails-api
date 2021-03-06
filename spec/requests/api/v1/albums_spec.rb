# frozen_string_literal: true

require 'rails_helper'

describe '/api/v1/albums', type: :request do
  let(:valid_headers) { {} }

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_v1_albums_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    context 'with artist_slug' do
      let!(:artist) { create(:artist, name: 'foo') }

      context 'when the artist exists' do
        let!(:artist_albums) { create_list(:album, 2, artist: artist) }

        it 'returns the albums of the artist' do
          get api_v1_artist_albums_url(artist.slug), headers: valid_headers, as: :json
          expect(response.body).to eq({
            data: artist_albums.map do |album|
              {
                id: album.id, title: album.title, description: album.description,
                release_year: album.release_year, genre: album.genre.name,
                artist: album.artist.name
              }
            end,
            meta: { next_page: nil }
          }.to_json)
          expect(response).to be_successful
        end
      end
    end
  end

  describe 'GET /show' do
    let!(:album) { create(:album) }

    it 'renders a successful response' do
      get api_v1_album_url(album), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    subject(:create_an_album) do
      post(api_v1_albums_url, params: attributes, headers: valid_headers, as: :json)
    end

    context 'with valid parameters' do
      let(:attributes) do
        {
          title: 'IGOR',
          description: 'Produced entirely by Tyler',
          year: 2019,
          artist_id: create(:artist).id,
          genre_id: create(:genre).id
        }
      end

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
      let(:attributes) do
        {
          title: 'IGOR',
          description: 'Produced entirely by Tyler',
          year: 2019,
          artist_id: create(:artist).id,
          genre_id: nil
        }
      end

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
      patch(api_v1_album_url(album), params: new_attributes, headers: valid_headers, as: :json)
    end

    let!(:album) { create(:album) }

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
    let!(:album) { create(:album) }

    it 'destroys the requested album' do
      expect do
        delete(api_v1_album_url(album),
               headers: valid_headers, as: :json)
      end.to change(Album, :count).by(-1)
    end
  end
end
