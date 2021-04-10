# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/genres', type: :request do
  path '/api/v1/genres' do
    get('list genres') do
      tags 'Genres'

      response(200, 'successful') { run_test! }
    end
  end
end
