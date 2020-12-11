# frozen_string_literal: true

FactoryBot.define do
  sequence(:id) { |i| i }
  sequence(:project_name) { |i| "project_name_#{i}" }
  sequence(:description) { |i| "description_#{i}" }
end
