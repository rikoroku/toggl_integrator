# frozen_string_literal: true

require 'toggl_integrator/version'
require 'toggl_integrator/command'
require 'toggl_integrator/db'
require 'toggl_integrator/task'
require 'toggl_integrator/toggl'
require 'toggl_integrator/google_calendar'
require 'toggl_integrator/logging'
require 'toggl_integrator/file_util'
require 'logger'
require 'yaml'
require 'dotenv/load'

Dotenv.load('.env')

# module TogglIntegrator
module TogglIntegrator
end
