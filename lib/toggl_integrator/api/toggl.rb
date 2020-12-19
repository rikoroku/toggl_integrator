# frozen_string_literal: true

require 'togglv8'
require 'date'

module TogglIntegrator
  # class Toggl
  class Toggl
    attr_reader :dates

    def initialize(args)
      @dates = args[:date_generator].range_to_fetch
    end

    def my_projects
      api.my_projects(user).map do |i|
        {
          'id' => i['id'], 'name' => i['name']
        }
      end
    end

    def time_entries
      api.get_time_entries @dates.map { |k, v| [k, v.to_s] }.to_h
    end

    private

    def user
      @user ||= api.me true
    end

    def api
      @api ||= TogglV8::API.new ENV['TOGGL_API_TOKEN']
    end
  end
end
