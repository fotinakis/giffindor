require 'capybara/rspec'
require 'capybara-webkit'
require 'factory_girl_rails'

# Capybara config.
Capybara.javascript_driver = :webkit
Capybara::Webkit.configure do |config|
  config.allow_unknown_urls
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  # Rspec config.
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.disable_monkey_patching!
  config.order = :random
  Kernel.srand config.seed

  # DatabaseCleaner config.
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before(:each) do |example|
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end

  # Percy config.
  RSpec.configure do |config|
    config.before(:suite) do
      Percy.config.access_token = ENV['PERCY_TOKEN']
    end
    config.after(:suite) { Percy::Capybara.finalize_build }
  end
end
