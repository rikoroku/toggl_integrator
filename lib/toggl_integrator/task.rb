# config: utf-8

require "active_record"

module TogglIntegrator

  # Model class Task
  # @author rikoroku
  class Task < ActiveRecord::Base

    NOT_YET = 0
    DONE    = 1

    STATUS = {
      "NOT_YET" => NOT_YET,
      "DONE"    => DONE
    }.freeze

    def self.save_tasks data, dates, projects
      Task.where("DATE(at) NOT BETWEEN ? AND ?", dates[:start_date], dates[:end_date]).delete_all
      tasks_ids = Task.all.ids
      data.each do |d|
        next if d["stop"].nil? or d["pid"].nil?
        unless tasks_ids.include? d["id"]
          Task.create id:           d["id"],
                      project_name: projects.find { |i| i["id"] == d["pid"] }["name"],
                      description:  d["description"],
                      start:        d["start"],
                      stop:         d["stop"],
                      at:           d["at"],
                      status:       STATUS["NOT_YET"]
        end
      end

    end

  end

end