require 'rails_helper'

RSpec.describe 'User API', type: :request do
  let!(:user) { create(:user) }
  let(:user_params) { { username: user.username }.to_json }

  describe 'GET /api/v1/signup' do
    before { post '/api/v1/signup', params: user_params }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/login' do
    before { post '/api/v1/login', params: user_params }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
