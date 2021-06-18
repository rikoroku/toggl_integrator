# frozen_string_literal: true

module TogglIntegrator
  # class TogglTimeEntryFetcher
  class TogglTimeEntryFetcher
    def self.call(args)
      new(args).execute
    end

    def initialize(args)
      @toggl = args[:toggl]
    end

    def execute
      time_entries = @toggl.fetch_time_entries
      before_store
      store(time_entries)
    end

    private

    def before_store
      delete_already_existing_time_entries_outside_of_sync_targets
    end

    def delete_already_existing_time_entries_outside_of_sync_targets
      TimeEntry.delete_all_not_between(@toggl.dates[:start_date], @toggl.dates[:end_date])
    end

    def store(time_entries)
      time_entries.each do |time_entry|
        next unless can_create?(time_entry)

        TimeEntry.create_with({ time_entry: time_entry, projects: @toggl.my_projects })
      end
    end

    def can_create?(time_entry)
      return false if time_entry['stop'].nil? || time_entry['pid'].nil? ||
                      TimeEntry.all.ids.include?(time_entry['id'])

      true
    end
  end
end
