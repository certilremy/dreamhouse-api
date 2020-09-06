require 'swagger_helper'

describe 'Houses API' do
  path '/api/v1/houses' do
    get 'endpoint to get all the houses' do
      tags 'Houses'
      description 'This endpoint alow you to send request to get all the Houses. You must be logged in.'
      consumes 'application/json'
      security [basic_auth: []]
      response '200', 'Succefully get all the houses' do
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

  path '/api/v1/houses/{id}' do
    get 'Retrieves a single house with a given id' do
      tags 'Houses'
      description 'This endpoint alow you to send request to get a single Houses. You must be logged in.'
      produces 'application/json'
      security [basic_auth: []]
      parameter name: :id, in: :path, type: :integer

      response '200', 'house found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 description: { type: :string },
                 price: { type: :integer },
                 user_id: { type: :integer }
               },
               required: ['id']

        run_test!
      end

      response '404', 'House not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '401', 'Not authorized' do
        run_test!
      end
    end
  end

  path '/api/v1/houses' do
    post 'Creates a house' do
      tags 'Houses'
      description 'This endpoint alow you to send request to create an House. To do that the logged in user must be an admin. '
      consumes 'application/json'
      security [basic_auth: []]
      parameter name: :house, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          price: { type: :integer },
          description: { type: :string },
          number_0f_rooms: {type: :integer},
          user_id: { type: :integer }
        },
        required: %w[name price description user_id]
      }

      response '201', 'House created' do
        run_test!
      end

      response '401', 'Not authorized' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end

      response '200', "You're not alowed to perform this operation (user must be an admin)" do
        run_test!
      end
    end
  end

  path '/api/v1/houses/{id}' do
    patch 'Send request to update an house with a given ID' do
      tags 'Houses'
      description 'This endpoint alow you to send request to update an House. To do that, the logged in user must be an admin.'
      consumes 'application/json'
      security [basic_auth: []]
      parameter name: :id, in: :path, type: :integer
      parameter name: :house, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          price: { type: :integer },
          description: { type: :string },
          user_id: { type: :integer }
        },
        required: %w[name price description user_id]
      }

      response '201', 'House created' do
        run_test!
      end

      response '401', 'Not authorized' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end

      response '200', "You're not alowed to perform this operation (user must be an admin)" do
        run_test!
      end
    end
  end

  path '/api/v1/houses/{id}' do
    delete 'Delete a single house' do
      tags 'Houses'
      description 'This endpoint alow you to send request to delete a single Houses. You must be logged in and must be an admin.'
      produces 'application/json'
      security [basic_auth: []]
      parameter name: :id, in: :path, type: :integer

      response '200', 'house deleted' do
        run_test!
      end

      response '404', 'House not found' do
        run_test!
      end

      response '401', 'Not authorized' do
        run_test!
      end
    end
  end
end
