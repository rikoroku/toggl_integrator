# frozen_string_literal: true

require 'togglv8'
require 'date'

module TogglIntegrator
  module Generators
    module Toggl
      # class DateGenerator
      class DateGenerator
        def range_to_fetch
          # TODO: must be changed to way to specify the range of dates with environment variables
          { start_date: today - 1, end_date: today + 1 }
        end

        private

        def today
          @today ||= Date.today
        end
      end
    end
  end
end
