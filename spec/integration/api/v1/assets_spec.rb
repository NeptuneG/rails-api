# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/assets', type: :request do
  let(:database) { 'rails_api_test' }
  let(:id) { 1 }

  path '/api/v1/{database}/assets' do
    parameter(
      name: 'database', in: :path, type: :string,
      description: 'database name',
      schema: { default: 'rails_api_development' }
    )

    get('list assets') do
      tags('Assets')
      consumes('application/json')
      response(200, 'successful') { run_test! }
    end

    post('create asset') do
      tags('Assets')
      consumes('application/json')
      response(200, 'successful') { run_test! }
    end
  end

  path '/api/v1/{database}/assets/{id}' do
    parameter(
      name: 'database', in: :path, type: :string,
      description: 'database name',
      schema: { default: 'rails_api_development' }
    )
    parameter(name: 'id', in: :path, type: :string, description: 'id')

    get('show asset') do
      tags('Assets')
      consumes('application/json')
      response(200, 'successful') { run_test! }
    end

    patch('update asset') do
      tags('Assets')
      consumes('application/json')
      response(200, 'successful') { run_test! }
    end

    put('update asset') do
      tags('Assets')
      consumes('application/json')
      response(200, 'successful') { run_test! }
    end

    delete('delete asset') do
      tags('Assets')
      consumes('application/json')
      response(200, 'successful') { run_test! }
    end
  end
end
