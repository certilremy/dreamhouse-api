require 'rails_helper'

RSpec.describe 'House API', type: :request do
  let!(:user) { create(:user) }
  let!(:houses) { create_list(:house, 10, user_id: user.id) }
  let(:house_id) { houses.first.id }
  let!(:header) { auth_headers(user) }
  let!(:fake_header) { fake_headers }
  let(:house_id) { houses.first.id }

  describe 'GET /api/v1/houses with valid credential' do
    before { get '/api/v1/houses', params: {}, headers: header }
    it 'returns houses' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/houses with fake credential' do
    before do
      get '/api/v1/houses', params: {}, headers: fake_header
    end

    it 'returns status code 401' do
      expect(response).to have_http_status(401)
    end
  end

  describe 'GET /api/v1/houses/:id' do
    before do
      get "/api/v1/houses/#{house_id}", params: {}, headers: header
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'return the house id' do
      expect(json['house']['id']).to eq(1)
    end
  end

  describe 'POST /api/v1/houses' do
    let(:attributes) { { name: 'simple house for test', price: 12, user_id: user.id.to_s, description: " I'm a simple description for testing " }.to_json }

    context 'when the request is valid and the current user is admin' do
      before do
        user.admin = true
        user.save
        post '/api/v1/houses', params: attributes, headers: header
      end

      it 'get the name of the created an house' do
        expect(json['house']['name']).to eq('simple house for test')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the current user is not admin' do
      let(:attributes) { { name: 'simple house for test', price: 12, user_id: user.id.to_s, description: " I'm a simple description for testing " }.to_json }

      before do
        post '/api/v1/houses', params: attributes, headers: header
      end

      it 'return error' do
        expect(json['error']).to eq("You're not alowed to perform this operation")
      end
    end

    context 'when the data is invalid' do
      let(:invalid_attributes) { { name: 'simple house for test', user_id: user.id.to_s, description: " I'm a simple description for testing " }.to_json }

      before do
        user.admin = true
        user.save
        post '/api/v1/houses', params: invalid_attributes, headers: header
      end

      it 'return error' do
        expect(json['error']).to eq('Error saving the house')
      end
    end
  end

  describe 'PUT /api/v1/houses/:id' do
    let(:attributes) { { name: 'New name for house edit' }.to_json }

    context 'when the record exists' do
      before do
        user.admin = true
        user.save
        put "/api/v1/houses/#{house_id}", params: attributes, headers: header
      end

      it 'updates the record' do
        expect(json['house']['name']).to eq('New name for house edit')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'DELETE /api/v1/houses/:id' do
    before do
      user.admin = true
      user.save
      delete "/api/v1/houses/#{house_id}", params: {}, headers: header
    end

    it 'returns the delete message' do
      expect(json['message']).to eq('House was successfully deleted')
    end
  end
end
