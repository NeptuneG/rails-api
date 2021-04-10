# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/genres', type: :request do
  describe 'GET /index' do
    let(:valid_headers) { {} }

    it 'renders a successful response' do
      get(api_v1_genres_url, headers: valid_headers, as: :json)
      expect(response).to be_successful
    end
  end
end
