require 'swagger_helper'

describe 'favorites API' do
  path '/api/v1/favorites' do
    get 'endpoint to get all favorites' do
      tags 'favorites'
      description 'This endpoint alow you to send request to get all the favorites. You must be logged in.'
      consumes 'application/json'
      security [basic_auth: []]
      response '200', 'Succefully get all the favorites' do
        run_test!
      end
      response '401', 'Error Unauthorized, you must pass the login token in the authorize form to login' do
        let(:user) { { username: 'foo' } }
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  path '/api/v1/house/{id}/favorite' do
    post 'Add an house to favorite ' do
      tags 'favorites'
      description 'This endpoint alow you to send request to add a given house as favorite.'
      produces 'application/json'
      security [basic_auth: []]
      parameter name: :id, in: :path, type: :integer
      response '200', 'House was successfully added to your favorite!' do
        run_test!
      end

      response '401', 'Not authorized' do
        run_test!
      end

      response '404', 'Not found' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  path '/api/v1/favorites/{id}' do
    patch 'Send request to update a favorite with a given ID' do
      tags 'favorites'
      description 'This endpoint alow you to send request to update a favorite'
      consumes 'application/json'
      security [basic_auth: []]
      parameter name: :id, in: :path, type: :integer
      parameter name: :favorite, in: :body, schema: {
        type: :object,
        properties: {
          house_id: { type: :integer }
        },
        required: %w[house_id]
      }

      response '201', 'favorite created' do
        run_test!
      end

      response '401', 'Not authorized' do
        run_test!
      end

      response '401', 'Not found' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  path '/api/v1/favorites/{id}' do
    delete 'Delete a single favorite' do
      tags 'favorites'
      description 'This endpoint alow you to send request to delete a single favorites.'
      produces 'application/json'
      security [basic_auth: []]
      parameter name: :id, in: :path, type: :integer

      response '200', 'favorite deleted' do
        run_test!
      end

      response '404', 'favorite not found' do
        run_test!
      end

      response '401', 'Not authorized' do
        run_test!
      end
    end
  end
end
