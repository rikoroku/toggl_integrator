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

  end

end