require 'swagger_helper'

describe 'Users API' do
  path '/api/v1/signup' do
    post 'signup endpoint' do
      tags 'Users'
      description "This endpoint alow you to send request to create a User. You don't neet to be authorize"
      consumes 'application/json'
      parameter username: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string }
        },
        required: %w[username]
      }

      response '201', 'signup successfully, you can grab the token to peform other operation' do
        let(:user) { { username: 'certilremy' } }
        run_test!
      end

      response '422', 'invalid request, username to short minimum character is 4' do
        let(:user) { { username: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/login' do
    post 'Login endpoint' do
      tags 'Users'
      description "This endpoint alow you to send request to login a User. You don't neet to be authorize"
      consumes 'application/json'
      parameter username: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string }
        },
        required: %w[username]
      }

      response '201', 'login successfully to the app' do
        let(:user) { { username: 'certilremy' } }
        run_test!
      end

      response '422', 'invalid request ' do
        let(:user) { { username: 'foo' } }
        run_test!
      end
    end
  end
end
