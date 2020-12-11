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
      TimeEntryService.fetch_and_store
      GoogleCalendar.sync_time_entries
    rescue StandardError => e
      puts "[ERROR] An unexpected error has occurred: #{e.message}"
      Logging.error(e.message)
    end
  end
end
