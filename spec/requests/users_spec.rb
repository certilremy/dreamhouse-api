require 'rails_helper'

RSpec.describe 'User API', type: :request do
  let(:attributes) { { "username": "certilremytes" } }

  describe 'POST /api/v1/signup' do
    before { post '/api/v1/signup', params: attributes }

    it 'creates a new user' do
      expect(json['token']).not_to be_empty
    end
  end

  describe 'POST /api/v1/login ' do
    before { post '/api/v1/login', params: attributes }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
