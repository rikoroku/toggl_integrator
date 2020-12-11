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
end
