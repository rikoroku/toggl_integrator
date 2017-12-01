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
      options = Options.parse! @argv

      DB.prepare
    end

  end

end