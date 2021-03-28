# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/genres', type: :request do
  path '/api/v1/genres' do
    get('list genres') do
      tags 'Genres'

      response(200, 'successful') { run_test! }
    end

    post('create genre') do
      tags 'Genres'
      consumes 'application/json'
      parameter name: :genre, in: :body, schema: {
        type: :object,
        properties: { name: { type: :string } },
        required: %w[name]
      }

      response(201, 'successful') do
        let(:genre) { attributes_for(:genre) }
        run_test!
      end
    end
  end

  path '/api/v1/genres/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show genre') do
      tags 'Genres'

      response(200, 'successful') do
        let(:id) { create(:genre).id }

        run_test!
      end
    end

    patch('update genre') do
      tags 'Genres'
      consumes 'application/json'
      parameter name: :genre, in: :body, schema: {
        type: :object,
        properties: { name: { type: :string } }
      }

      response(200, 'successful') do
        let(:genre) { create(:genre) }
        let(:id) { genre.id }
        let(:params) { genre.attributes }

        run_test!
      end
    end

    put('update genre') do
      tags 'Genres'
      consumes 'application/json'
      parameter name: :genre, in: :body, schema: {
        type: :object,
        properties: { name: { type: :string } }
      }

      response(200, 'successful') do
        let(:genre) { create(:genre) }
        let(:id) { genre.id }

        run_test!
      end
    end

    delete('delete genre') do
      tags 'Genres'

      response(204, 'successful') do
        let(:id) { create(:genre).id }

        run_test!
      end
    end
  end
end
