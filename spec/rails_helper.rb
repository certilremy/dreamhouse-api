# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'shoulda/matchers'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include FactoryBot::Syntax::Methods
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
  config.filter_rails_from_backtrace!

  def json
    JSON.parse(response.body)
  end

  def auth_headers(user)
    {
      'Authorization' => 'Bearer ' + ApplicationController.new.encode_token({ user_id: user.id }),
      'Content-Type' => 'application/json'
    }
  end

  def fake_headers
    {
      'Authorization' => 'Bearer 1234567890',
      'Content-Type' => 'application/json'
    }
  end
end
