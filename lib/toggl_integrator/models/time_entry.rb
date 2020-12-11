# frozen_string_literal: true

# config: utf-8

require 'active_record'

module TogglIntegrator
  # class TimeEntry
  class TimeEntry < ActiveRecord::Base
    STATUS = { NOT_YET: 0, DONE: 1 }.freeze

    class << self
      def delete_all_not_between(start_date, end_date)
        TimeEntry.where('DATE(at) NOT BETWEEN ? AND ?',
                        start_date, end_date).delete_all
      end

      def create_with(args)
        time_entry = args[:time_entry]
        TimeEntry.create({
                           id: time_entry['id'],
                           project_name: project_name(args),
                           description: time_entry['description'],
                           start: time_entry['start'],
                           stop: time_entry['stop'],
                           at: time_entry['at'],
                           status: STATUS[:NOT_YET]
                         })
      end

      private

      def project_name(args)
        args[:projects].find { |i| i['id'] == args[:time_entry]['pid'] }['name']
      end
    end
  end
end
