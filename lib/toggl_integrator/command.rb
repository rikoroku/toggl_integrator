# frozen_string_literal: true

# config: utf-8

require 'fileutils'

module TogglIntegrator
  # execute tasks for command line base
  # @author rikoroku
  class Command
    def self.run
      new.execute
    end

    def initialize
      DB.prepare
      FileUtils.mkdir_p File.dirname File.join(ENV['HOME'], '.toggl_integrator', 'log')
    end

    def execute
      Toggl.new.save_time_entries
      GoogleCalendar.new.insert_time_entries
    rescue StandardError => e
      Logger.new("#{ENV['HOME']}/.toggl_integrator/log").error "Error: #{e.message}"
    end
  end
end
