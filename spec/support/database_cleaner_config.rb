RSpec.configure do |config|
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
end
