require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'DREAM HOUSE API',
        version: 'v1',
        description: 'Welcome to dream house api documentation. Use the request below to sent request to test the api'
      },
      components: {
        securitySchemes: {
          basic_auth: {
            type: :http,
            scheme: :bearer
          }
        }
      },
      paths: {},
      servers: [
        {
          url: 'https://dreamhouse-swagger.herokuapp.com/'
        }
      ]
    }

  }
  config.swagger_format = :yaml
end
