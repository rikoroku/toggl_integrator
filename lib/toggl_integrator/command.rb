# frozen_string_literal: true

module TogglIntegrator
  # class Command
  class Command
    def self.run
      new.execute
    end

    def initialize
      DB.prepare
    end

    def execute
      TimeEntoryService.fetch_and_store
      GoogleCalendar.sync_time_entries
    rescue StandardError => e
      Logging.error(e.message)
    end
  end
end
