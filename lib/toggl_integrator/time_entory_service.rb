# frozen_string_literal: true

module TogglIntegrator
  # class TimeEntoryService
  class TimeEntoryService
    class << self
      def fetch_and_store
        before_store
        Toggl.time_entries.each do |time_entory|
          next if createable?(time_entory)

          TimeEntory.create_with_toggl({ time_entory: time_entory,
                                         projects: Toggl.my_projects })
        end
      end

      private

      def dates
        return @dates if @dates.present?

        today = Date.today
        @dates = { start_date: today - 1, end_date: today + 1 }
      end

      def createable?(time_entory)
        time_entory['stop'].nil? || time_entory['pid'].nil? ||
          TimeEntory.all.ids.include?(time_entory['id'])
      end

      def before_store
        TimeEntory.delete_all_not_between(dates[:start_date], dates[:end_date])
      end
    end
  end
end
