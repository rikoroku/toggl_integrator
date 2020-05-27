# frozen_string_literal: true

require 'toggl_integrator/version'
require 'toggl_integrator/command'
require 'toggl_integrator/db'
require 'toggl_integrator/task'
require 'toggl_integrator/toggl'
require 'toggl_integrator/google_calendar'
require 'toggl_integrator/logging'
require 'logger'
require 'yaml'
require 'dotenv/load'

module TogglIntegrator
  Dotenv.load('.env')
  FileUtils.mkdir_p File.dirname File.join(ENV['PROJECT_PATH'], '.toggl_integrator', 'log')
end
