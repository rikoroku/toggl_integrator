# frozen_string_literal: true

require 'togglv8'
require 'date'

module TogglIntegrator
  # class Toggl
  class Toggl
    class << self
      def my_projects
        user = api.me true
        api.my_projects(user).map do |i|
          {
            'id' => i['id'], 'name' => i['name']
          }
        end
      end

      def time_entries
        api.get_time_entries dates.map { |k, v| [k, v.to_s] }.to_h
      end

      private

      def api
        @api ||= TogglV8::API.new ENV['TOGGL_API_TOKEN']
      end

      def dates
        return @dates if @dates.present?

        today = Date.today
        @dates = { start_date: today - 1, end_date: today + 1 }
      end
    end
  end
end
