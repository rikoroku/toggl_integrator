# frozen_string_literal: true

require 'toggl_integrator/version'
require 'toggl_integrator/command'
require 'toggl_integrator/db'
require 'toggl_integrator/models/time_entry'
require 'toggl_integrator/api/toggl'
require 'toggl_integrator/api/google_calendar'
require 'toggl_integrator/utils/logging'
require 'toggl_integrator/utils/file_util'
require 'toggl_integrator/services/toggl_time_entry_fetcher'
require 'toggl_integrator/services/google_calendar_syncer'
require 'toggl_integrator/generators/toggl/date_generator'
require 'logger'
require 'yaml'
require 'dotenv/load'

Dotenv.load('.env')

# module TogglIntegrator
module TogglIntegrator
  ActiveRecord::Base.default_timezone = :local
end
