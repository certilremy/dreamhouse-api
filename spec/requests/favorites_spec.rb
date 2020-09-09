require 'rails_helper'

RSpec.describe 'Favorite API', type: :request do
  let!(:user) { create(:user) }
  let!(:house) { create(:house, user_id: user.id) }
  let!(:favorites) { create_list(:favorite, 10, user_id: user.id, house_id: house.id) }
  let(:favorite_id) { favorites.first.id }
  let!(:header) { auth_headers(user) }
  let!(:fake_header) { fake_headers }

  describe 'GET /api/v1/favorites with valid credential' do
    before { get '/api/v1/favorites', params: {}, headers: header }
    it 'returns favorites' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/favorites with fake credential' do
    before do
      get '/api/v1/favorites', params: {}, headers: fake_header
    end

    it 'returns status code 401' do
      expect(response).to have_http_status(401)
    end
  end

  describe 'POST /api/v1/house/:id/favorite' do
    let(:attributes) { { house_id: house.id.to_s, user_id: user.id.to_s }.to_json }

    context 'when the request is valid ' do
      before do
        post "/api/v1/house/#{house.id}/favorite", params: attributes, headers: header
      end

      it 'get the name of the created an favorite' do
        puts 'the json'
        puts json
        expect(json['message']).to eq('House was successfully added to your favorite!')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PUT /api/v1/favorites/:id' do
    let(:attributes) { { house_id: house.id.to_s }.to_json }

    context 'when the record exists' do
      before do
        put "/api/v1/favorites/#{favorite_id}", params: attributes, headers: header
      end

      it 'updates the record' do
        expect(json['message']).to eq('Favorite was successfully updated!')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'DELETE /api/v1/favorites/:id' do
    before do
      user.admin = true
      user.save
      delete "/api/v1/favorites/#{favorite_id}", params: {}, headers: header
    end

    it 'returns the delete message' do
      expect(json['message']).to eq('favorite was successfully deleted')
    end
  end
end
