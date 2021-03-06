# frozen_string_literal: true

require 'active_record'

module TogglIntegrator
  # class DB
  class DB
    def self.prepare
      new.prepare
    end

    def initialize
      create_database_if_not_exists
      connect_database
    end

    def prepare
      create_table_if_not_exists
    end

    private

    def connect_database
      spec = {
        adapter: 'sqlite3',
        database: FileUtil.join('toggl_integrator.sqlite3')
      }
      ActiveRecord::Base.establish_connection spec
    end

    def connection
      @connection ||= ActiveRecord::Base.connection
    end

    def create_table_if_not_exists
      return if connection.table_exists? :time_entries

      create_time_entries_table

      connection.add_index :time_entries, :start
      connection.add_index :time_entries, :stop
      connection.add_index :time_entries, :status
    end

    def create_time_entries_table
      connection.create_table :time_entries do |t|
        t.column :project_name, :string,    null: true
        t.column :description,  :string,    null: true
        t.column :start,        :timestamp, null: false
        t.column :stop,         :timestamp, null: false
        t.column :at,           :timestamp, null: false
        t.column :status,       :integer,   default: 0, null: true
        t.timestamps
      end
    end

    def create_database_if_not_exists
      FileUtil.new_file_if_not_exists('toggl_integrator.sqlite3')
    end
  end
end
