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

    class << self
      def info(msg)
        info_message = make_info_message(msg)
        puts info_message
        instance.logger.info info_message
      end

      def error(msg)
        error_msg = make_error_message(msg)
        puts error_msg
        instance.logger.error error_msg
      end

      private

      def make_info_message(body)
        "[INFO] #{body}"
      end

      def make_error_message(body)
        "[ERROR] An unexpected error has occurred: #{body}"
      end
    end
  end
end
