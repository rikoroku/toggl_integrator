# config: utf-8

require "togglv8"
require "date"

module TogglIntegrator

  # execute tasks for command line base
  # @author rikoroku
  class Command

    def self.run
      new.execute
    end

    def initialize
      DB.prepare
      @task = Task.new
      @log  = Logger.new "./tmp/log"
    end

    def execute
      save_time_entries

    rescue => e
      @log.error "Error: #{e.message}"
    end

    private

      def save_time_entries
        toggl_api    = TogglV8::API.new ENV["TOGGL_API_TOKEN"]
        user         = toggl_api.me all=true
        projects     = toggl_api.my_projects(user).map { |i| { "id" => i["id"], "name" => i["name"] } }
        today        = Date.today
        dates        = { :start_date => today-1, :end_date => today+1 }
        time_entries = toggl_api.get_time_entries dates.map { |k, v| [k, v.to_s] }.to_h
        @task.save_tasks time_entries, dates, projects
      end

  end

end