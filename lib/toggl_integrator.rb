# frozen_string_literal: true

require 'toggl_integrator/version'
require 'toggl_integrator/command'
require 'toggl_integrator/db'
require 'toggl_integrator/models/time_entory'
require 'toggl_integrator/services/toggl'
require 'toggl_integrator/services/google_calendar'
require 'toggl_integrator/utils/logging'
require 'toggl_integrator/utils/file_util'
require 'toggl_integrator/services/time_entory_service'
require 'logger'
require 'yaml'
require 'dotenv/load'

Dotenv.load('.env')

# module TogglIntegrator
module TogglIntegrator
end
