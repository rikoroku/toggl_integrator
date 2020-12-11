# frozen_string_literal: true

FactoryBot.define do
  factory :time_entry, class: TogglIntegrator::TimeEntry do
    project_name { generate :project_name }
    description { generate :description }
    at { Date.today }
    status { TogglIntegrator::TimeEntry::STATUS[:NOT_YET] }
  end
end
