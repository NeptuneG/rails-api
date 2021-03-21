# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/genres', type: :request do
  path '/api/v1/{database}/genres' do
    parameter(
      name: 'database', in: :path, type: :string,
      description: 'database name',
      schema: { default: 'rails_api_development' }
    )

    get('list genres') do
      tags('Genres')
      consumes('application/json')
      response(200, 'successful') { run_test! }
    end

    post('create genre') do
      tags('Genres')
      consumes('application/json')
      parameter(
        name: 'name', in: :body, type: :string,
        description: 'genre name',
        schema: {
          type: :object,
          properties: {
            name: { type: :string }
          },
          required: ['name']
        }
      )
      response(200, 'successful') { run_test! }
    end
  end

  path '/api/v1/{database}/genres/{id}' do
    parameter(
      name: 'database', in: :path, type: :string,
      description: 'database name',
      schema: { default: 'rails_api_development' }
    )
    parameter(name: 'id', in: :path, type: :string, description: 'id')

    get('show genre') do
      tags('Genres')
      consumes('application/json')
      response(200, 'successful') { run_test! }
    end

    patch('update genre') do
      tags('Genres')
      consumes('application/json')
      response(200, 'successful') { run_test! }
    end

    put('update genre') do
      tags('Genres')
      consumes('application/json')
      response(200, 'successful') { run_test! }
    end

    delete('delete genre') do
      tags('Genres')
      consumes('application/json')
      response(200, 'successful') { run_test! }
    end
  end
end
