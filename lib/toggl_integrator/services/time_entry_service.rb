# frozen_string_literal: true

module TogglIntegrator
  # class TimeEntryService
  class TimeEntryService
    class << self
      def fetch_and_store
        before_store
        Toggl.time_entries.each do |time_entry|
          next if createable?(time_entry)

          TimeEntry.create_with({ time_entry: time_entry,
                                  projects: Toggl.my_projects })
        end
      end

      private

      def dates
        return @dates if @dates.present?

        today = Date.today
        @dates = { start_date: today - 1, end_date: today + 1 }
      end

      def createable?(time_entry)
        time_entry['stop'].nil? || time_entry['pid'].nil? ||
          TimeEntry.all.ids.include?(time_entry['id'])
      end

      def before_store
        TimeEntry.delete_all_not_between(dates[:start_date], dates[:end_date])
      end
    end
  end
end
