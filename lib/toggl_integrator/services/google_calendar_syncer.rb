# frozen_string_literal: true

module TogglIntegrator
  # class GoogleCalendarSyncer
  class GoogleCalendarSyncer
    def self.call(args)
      new(args).execute
    end

    def initialize(args)
      @google_calendar = args[:google_calendar]
    end

    def execute
      time_entries.each do |time_entry|
        res = @google_calendar.sync(time_entry)
        time_entry.update status: TogglIntegrator::TimeEntry::STATUS[:DONE]
        Logging.info("Synced event '#{res.summary}' (#{res.id})")
      end
    end

    private

    def time_entries
      TimeEntry.where status: TogglIntegrator::TimeEntry::STATUS[:NOT_YET]
    end
  end
end
