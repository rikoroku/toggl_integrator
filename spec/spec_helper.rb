# frozen_string_literal: true

require 'toggl_integrator'
require 'timecop'
require 'factory_bot'
require 'date'

FactoryBot.definition_file_paths = %w[./spec/factories]
FactoryBot.find_definitions

RSpec.configure do |config|
  config.order = :random
  config.include FactoryBot::Syntax::Methods
end

TogglIntegrator::DB.prepare
