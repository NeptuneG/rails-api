# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/albums', type: :request do
  path '/api/v1/albums' do
    get('list albums') do
      tags 'Albums'

      response(200, 'successful') { run_test! }
    end

    post('create album') do
      tags 'Albums'
      consumes 'application/json'
      parameter name: :album, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          release_year: { type: :integer },
          artist_id: { type: :string },
          genre_id: { type: :string }
        },
        required: %w[title genre_id]
      }

      response(201, 'successful') do
        let(:album) do
          attributes_for(:album, artist_id: create(:artist).id,
                                 genre_id: create(:genre).id)
        end
        run_test!
      end
    end
  end

  path '/api/v1/albums/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show album') do
      tags 'Albums'

      response(200, 'successful') do
        let(:id) { create(:album).id }

        run_test!
      end
    end

    patch('update album') do
      tags 'Albums'
      consumes 'application/json'
      parameter name: :album, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          release_year: { type: :integer },
          artist_id: { type: :string },
          genre_id: { type: :string }
        }
      }

      response(200, 'successful') do
        let(:album) { create(:album) }
        let(:id) { album.id }
        let(:params) { album.attributes }

        run_test!
      end
    end

    put('update album') do
      tags 'Albums'
      consumes 'application/json'
      parameter name: :album, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          release_year: { type: :integer },
          artist_id: { type: :string },
          genre_id: { type: :string }
        }
      }

      response(200, 'successful') do
        let(:album) { create(:album) }
        let(:id) { album.id }

        run_test!
      end
    end

    delete('delete album') do
      tags 'Albums'
      response(204, 'successful') do
        let(:id) { create(:album).id }

        run_test!
      end
    end
  end
end
