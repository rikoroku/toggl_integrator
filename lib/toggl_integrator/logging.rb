# frozen_string_literal: true

module TogglIntegrator
  # Logging
  class Logging
    include Singleton

    attr_reader :logger

    def initialize
      FileUtil.new_file_if_not_exists('log')
      @logger = Logger.new(FileUtil.join('log'))
    end

    def self.info(msg)
      instance.logger.info msg
    end

    def self.error(msg)
      instance.logger.error msg
    end
  end
end
