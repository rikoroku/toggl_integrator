# config: utf-8

require "togglv8"
require "date"

module TogglIntegrator

  # Class Toggl for Toggl API
  # @author rikoroku
  class Toggl

    attr_accessor :log, :config

    def initialize
      yield self if block_given?
      @toggl_api  = TogglV8::API.new @config["toggl"]["api_token"]
      @user       = @toggl_api.me all=true
    end

    def save_time_entries
      today        = Date.today
      dates        = { :start_date => today-1, :end_date => today+1 }
      projects     = @toggl_api.my_projects(@user).map { |i| { "id" => i["id"], "name" => i["name"] } }
      time_entries = @toggl_api.get_time_entries dates.map { |k, v| [k, v.to_s] }.to_h
      Task.save_tasks time_entries, dates, projects
    rescue => e
      @log.error "Error: #{e.message}"
    end

  end

end