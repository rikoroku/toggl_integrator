# config: utf-8

require "fileutils"
require "active_record"

module TogglIntegrator

  # Connection processing to DB
  # @author rikoroku
  module DB

    # Connection processing to DB and Creating tables
    # @return [void]
    def self.prepare
      database_path = File.join(".toggl_integrator", "toggl_integrator.sqlite3")

      connect_database database_path
      create_table_if_not_exists database_path
    end

    def self.connect_database path
      spec = { adapter: "sqlite3", database: path }
      ActiveRecord::Base.establish_connection spec
    end

    def self.create_table_if_not_exists path
      create_database_path path

      connection = ActiveRecord::Base.connection

      return if connection.table_exists? :tasks

      connection.create_table :tasks do |t|
        t.column :project_name, :string,    null:true
        t.column :description,  :string,    null:true
        t.column :start,        :timestamp, null:false
        t.column :stop,         :timestamp, null:false
        t.column :at,           :timestamp, null:false
        t.column :status,       :integer,   default: 0, null:true
        t.timestamps
      end
      connection.add_index :tasks, :start
      connection.add_index :tasks, :stop
      connection.add_index :tasks, :status
    end

    def self.create_database_path path
      FileUtils.mkdir_p File.dirname(path)
    end

    private_class_method :connect_database, :create_table_if_not_exists, :create_database_path

  end

end