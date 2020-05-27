# frozen_string_literal: true

module TogglIntegrator
  # Logging
  # @author rikoroku
  class Logging
    include Singleton

    attr_reader :logger

    def initialize
      @logger = Logger.new("#{ENV['PROJECT_PATH']}/.toggl_integrator/log")
    end

    def self.info(msg)
      instance.logger.info msg
    end

    def self.error(msg)
      instance.logger.error msg
    end
  end
end
