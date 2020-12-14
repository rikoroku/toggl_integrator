# frozen_string_literal: true

module TogglIntegrator
  # class TimeEntryService
  class TimeEntryService
    class << self
      def fetch_and_store
        before_store
        Toggl.time_entries.each do |time_entry|
          next unless can_store?(time_entry)

          TimeEntry.create_with({ time_entry: time_entry,
                                  projects: Toggl.my_projects })
        end
      end

      private

      def dates
        return @dates if @dates.present?

        today = Date.today
        # must be changed to way to specify the range of dates with environment variables
        @dates = { start_date: today - 1, end_date: today + 1 }
      end

      def can_store?(time_entry)
        return false if time_entry['stop'].nil? || time_entry['pid'].nil? ||
                        TimeEntry.all.ids.include?(time_entry['id'])

        true
      end

      def before_store
        TimeEntry.delete_all_not_between(dates[:start_date], dates[:end_date])
      end
    end
  end
end
