# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'TogglIntegrator::TimeEntry' do
  let(:today) { Date.today }
  after { TogglIntegrator::TimeEntry.delete_all }

  describe 'delete_all_not_between' do
    let!(:time_entry) { create(:time_entry, start: today, stop: today) }

    before { Timecop.freeze(today) }

    context 'when data exist' do
      context 'within the range of start to stop dates' do
        it 'should not be deleted' do
          TogglIntegrator::TimeEntry.delete_all_not_between(today, today)

          expect(TogglIntegrator::TimeEntry.all.size).to eq 1
        end
      end

      context 'outside the range of start to stop dates' do
        it 'should be deleted' do
          yesterday = Date.today - 1.day
          TogglIntegrator::TimeEntry.delete_all_not_between(yesterday, yesterday)

          expect(TogglIntegrator::TimeEntry.all.size).to eq 0
        end
      end
    end
  end

  describe 'create_with' do
    it 'should be created with args' do
      args = {
        time_entry: { 'id' => 1,
                      'pid' => 1,
                      'start' => '2000-01-01T10:00:00+00:00',
                      'stop' => '2000-01-01T13:00:00+00:00',
                      'description' => 'Test',
                      'at' => '2000-01-01T13:00:00+00:00' },
        projects: [{ 'id' => 1, 'name' => 'Project1' }, { 'id' => 2, 'name' => 'Project2' }]
      }

      TogglIntegrator::TimeEntry.create_with(args)

      expect(TogglIntegrator::TimeEntry.all.size).to eq 1
      expect(TogglIntegrator::TimeEntry.first.id).to eq args[:time_entry]['id']
      expect(TogglIntegrator::TimeEntry.first.description).to eq args[:time_entry]['description']
      expect(TogglIntegrator::TimeEntry.first.project_name).to eq args[:projects][0]['name']
    end
  end
end
