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
      TogglTimeEntryFetcher.call(toggl: Toggl.new)
      GoogleCalendarSyncer.call(google_calendar: GoogleCalendar.new)
    rescue StandardError => e
      puts "[ERROR] An unexpected error has occurred: #{e.message}"
      Logging.error(e.message)
    end
  end
end
