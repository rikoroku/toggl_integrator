# frozen_string_literal: true

module TogglIntegrator
  # class TogglTimeEntryFetcher
  class TogglTimeEntryFetcher
    def self.call(args)
      new(args).execute
    end

    def initialize(args)
      @toggl = args[:toggl]
      @time_entries = []
    end

    def execute
      fetch
      before_store
      store
    end

    private

    def before_store
      delete_already_existing_time_entries_outside_of_sync_targets
    end

    def delete_already_existing_time_entries_outside_of_sync_targets
      TimeEntry.delete_all_not_between(dates[:start_date], dates[:end_date])
    end

    def fetch
      @time_entries = @toggl.time_entries
    end

    def store
      @time_entries.each do |time_entry|
        next unless can_create?(time_entry)

        TimeEntry.create_with({ time_entry: time_entry, projects: @toggl.my_projects })
      end
    end

    def can_create?(time_entry)
      return false if time_entry['stop'].nil? || time_entry['pid'].nil? ||
                      TimeEntry.all.ids.include?(time_entry['id'])

      true
    end

    def dates
      return @dates if @dates.present?

      today = Date.today
      # TODO: must be changed to way to specify the range of dates with environment variables
      @dates = { start_date: today - 1, end_date: today + 1 }
    end
  end
end
