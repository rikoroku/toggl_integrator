# config: utf-8

module TogglIntegrator

  # execute tasks for command line base
  # @author rikoroku
  class Command

    def self.run argv
      new(argv).execute
    end

    def initialize argv
      @argv = argv
    end

    def execute
      options     = Options.parse! @argv
      sub_command = options.delete :command

      DB.prepare

      case sub_command
      when "start"
        start_task options[:interval]
      when "stop"
        stop_task
      when "status"
        show_status
      end

    rescue => e
      abort "Error: #{e.message}"
    end

    def start_task
    end

    def stop_task
    end

    def show_status
    end

  end

end