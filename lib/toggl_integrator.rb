# frozen_string_literal: true

require 'toggl_integrator/version'
require 'toggl_integrator/command'
require 'toggl_integrator/db'
require 'toggl_integrator/time_entory'
require 'toggl_integrator/toggl'
require 'toggl_integrator/google_calendar'
require 'toggl_integrator/logging'
require 'toggl_integrator/file_util'
require 'toggl_integrator/time_entory_service'
require 'logger'
require 'yaml'
require 'dotenv/load'

Dotenv.load('.env')

# module TogglIntegrator
module TogglIntegrator
end
