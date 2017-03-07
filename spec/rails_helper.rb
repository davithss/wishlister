ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'webmock/rspec'


OmniAuth.config.test_mode = true
omniauth_hash = {
  'provider' => 'foursquare',
  'uid' => '12345',
  'info' => {
    'name' => 'Chevchenko',
    'email' => 'hi@chev.com',
  },
  'credentials' => {
    'token' => '989u9h9h89',
    'secret' => 'hahaeuh23828',
  }
}
OmniAuth.config.add_mock(:foursquare, omniauth_hash)

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.before(:each) do |example|
    DatabaseCleaner.strategy = if example.metadata[:browser]
      :truncation
    else
      :transaction
    end
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end


  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
