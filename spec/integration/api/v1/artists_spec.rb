# frozen_string_literal: true

require 'swagger_helper'

describe 'api/v1/artists', type: :request do
  path '/api/v1/artists' do
    get('list artists') do
      tags 'Artists'

      response(200, 'successful') { run_test! }
    end

    post('create artist') do
      tags 'Artists'
      consumes 'application/json'
      parameter name: :artist, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string }
        },
        required: %w[name]
      }

      response(201, 'successful') do
        let(:artist) { attributes_for(:artist) }

        run_test!
      end
    end
  end

  path '/api/v1/artists/{artist_slug}' do
    parameter name: 'artist_slug', in: :path, type: :string, description: "artist's name"

    get('show artist') do
      tags 'Artists'

      response(200, 'successful') do
        let(:artist_slug) { create(:artist).slug }

        run_test!
      end
    end

    patch('update artist') do
      tags 'Artists'
      consumes 'application/json'
      parameter name: :artist, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string }
        }
      }

      response(200, 'successful') do
        let(:artist) { create(:artist) }
        let(:artist_slug) { artist.slug }
        let(:params) { { name: 'New Name' } }

        run_test!
      end
    end

    put('update artist') do
      tags 'Artists'
      consumes 'application/json'
      parameter name: :artist, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string }
        }
      }

      response(200, 'successful') do
        let(:artist) { create(:artist) }
        let(:artist_slug) { artist.slug }
        let(:params) { { description: 'New Desc' } }

        run_test!
      end
    end

    delete('delete artist') do
      tags 'Artists'

      response(204, 'successful') do
        let(:artist_slug) { create(:artist).slug }

        run_test!
      end
    end
  end

  path '/api/v1/artists/{artist_slug}/albums' do
    parameter name: 'artist_slug', in: :path, type: :string, description: "artist's name"

    get('list albums of an artist') do
      tags 'Artists'
      let(:artist_slug) { create(:artist).slug }

      response(200, 'successful') { run_test! }
    end
  end
end
