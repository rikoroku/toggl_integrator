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
      @log    = Logger.new "./tmp/log"
      @config = YAML.load_file "config.yml"
    end

    def execute
      Toggl.new { |o| o.log, o.config = @log, @config }.save_time_entries
      GoogleCalendar.new { |o| o.log, o.config = @log, @config }.insert_time_entries
    rescue => e
      @log.error "Error: #{e.message}"
    end

  end

end