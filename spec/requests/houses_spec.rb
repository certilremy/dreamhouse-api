require 'rails_helper'

RSpec.describe 'House API', type: :request do
  let!(:user) { create(:user) }
  let!(:houses) { create_list(:house, 10, user_id: user.id) }
  let(:house_id) { houses.first.id }

  describe 'GET /api/v1/houses' do
    #before { get '/api/v1/houses', headers: { 'Authorization' => "Bearer #{auth_headers(user)}" } }
    it 'returns houses' do
     # expect(json).not_to be_empty
      #expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      #expect(response).to have_http_status(200)
    end
  end
end
