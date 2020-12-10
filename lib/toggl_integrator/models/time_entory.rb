# frozen_string_literal: true

# config: utf-8

require 'active_record'

module TogglIntegrator
  # class TimeEntory
  class TimeEntory < ActiveRecord::Base
    STATUS = { NOT_YET: 0, DONE: 1 }.freeze

    class << self
      def delete_all_not_between(start_date, end_date)
        TimeEntory.where('DATE(at) NOT BETWEEN ? AND ?',
                         start_date, end_date).delete_all
      end

      def create_with(args)
        time_entory = args[:time_entory]
        TimeEntory.create({
                            id: time_entory['id'],
                            project_name: project_name(args),
                            description: time_entory['description'],
                            start: time_entory['start'],
                            stop: time_entory['stop'],
                            at: time_entory['at'],
                            status: STATUS[:NOT_YET]
                          })
      end

      private

      def project_name(args)
        args[:projects].find { |i| i['id'] == args[:time_entory]['pid'] }['name']
      end
    end
  end
end
