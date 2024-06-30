# frozen_string_literal: true

# See https://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.mock_with(:rspec) do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.disable_monkey_patching!
end
