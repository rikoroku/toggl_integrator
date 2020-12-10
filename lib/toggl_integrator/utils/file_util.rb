# frozen_string_literal: true

require 'fileutils'

module TogglIntegrator
  # FileUtil
  class FileUtil
    include Singleton

    attr_reader :project_path

    def initialize
      @project_path = "#{ENV['PROJECT_PATH']}/.toggl_integrator/"
    end

    def self.join(path)
      File.join(instance.project_path + path)
    end

    def self.new_file_if_not_exists(name)
      FileUtils.mkdir_p File.dirname join(name)
    end
  end
end
