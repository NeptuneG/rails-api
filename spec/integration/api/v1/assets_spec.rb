# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/assets', type: :request do
  path '/api/v1/assets' do
    get('list assets') do
      tags 'Assets'

      response(200, 'successful') { run_test! }
    end

    post('create asset') do
      tags 'Assets'
      consumes 'application/json'
      parameter name: :asset, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          genre_id: { type: :string }
        },
        required: %w[title genre_id]
      }

      response(201, 'successful') do
        let(:asset) { attributes_for(:asset, genre_id: create(:genre).id) }
        run_test!
      end
    end
  end

  path '/api/v1/assets/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show asset') do
      tags 'Assets'

      response(200, 'successful') do
        let(:id) { create(:asset).id }

        run_test!
      end
    end

    patch('update asset') do
      tags 'Assets'
      consumes 'application/json'
      parameter name: :asset, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          genre_id: { type: :string }
        }
      }

      response(200, 'successful') do
        let(:asset) { create(:asset) }
        let(:id) { asset.id }
        let(:params) { asset.attributes }

        run_test!
      end
    end

    put('update asset') do
      tags 'Assets'
      consumes 'application/json'
      parameter name: :asset, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          genre_id: { type: :string }
        }
      }

      response(200, 'successful') do
        let(:asset) { create(:asset) }
        let(:id) { asset.id }

        run_test!
      end
    end

    delete('delete asset') do
      tags 'Assets'
      response(204, 'successful') do
        let(:id) { create(:asset).id }

        run_test!
      end
    end
  end
end
