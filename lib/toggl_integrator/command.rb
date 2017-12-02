# config: utf-8

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
      Toggl.new(@log, @task).save_time_entries
    rescue => e
      @log.error "Error: #{e.message}"
    end

  end

end