# spec/spec_helper.rb
ENV['RACK_ENV'] ||= 'test'

require 'vcr'
require 'webmock/rspec'

# Load environment variables for testing (if using dotenv)
require 'dotenv'
Dotenv.load('.env.test') # Ensure you have a .env.test file with necessary variables


# Configure VCR
VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes" # Directory where cassettes will be saved
  config.hook_into :webmock                     # Use WebMock to hook into HTTP requests
  config.configure_rspec_metadata!              # Integrate with RSpec metadata
  config.default_cassette_options = { record: :once } # Record interactions once and replay
  config.allow_http_connections_when_no_cassette = false # Disallow real HTTP requests outside cassettes
  config.debug_logger = File.open("log/vcr_debug.log", "w")
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Integrate VCR with RSpec metadata
  config.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join('/').underscore.tr(' ', '_').gsub(/[^\w\/]+/, '')
    VCR.use_cassette(name, record: :once) { example.call }
  end
end
