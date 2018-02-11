# config: utf-8

require "google/apis/calendar_v3"
require "googleauth"
require "googleauth/stores/file_token_store"

require "fileutils"

module TogglIntegrator

  # Class Google for Google API
  # @author rikoroku
  class GoogleCalendar

    def initialize
      @service = Google::Apis::CalendarV3::CalendarService.new
      @service.client_options.application_name = YAML.load_file(File.join(__dir__, "../../config.yml"))["google"]["application_name"]
      @service.authorization = authorize
    end

    def insert_time_entries
      log = Logger.new("#{ENV["HOME"]}/.toggl_integrator/log")
      tasks = Task.where status: TogglIntegrator::Task::STATUS["NOT_YET"]
      tasks.each do |t|
        event = {
          summary: "#{t[:project_name]} : #{t[:description]}",
          start: {
            date_time: DateTime.parse("#{t[:start].localtime}")
          },
          end: {
            date_time: DateTime.parse("#{t[:stop].localtime}")
          },
          color_id: 8
        }

        event = @service.insert_event "primary", event, send_notifications: true
        t.update status: TogglIntegrator::Task::STATUS["DONE"]
        log.info "Created event '#{event.summary}' (#{event.id})"
      end
    rescue => e
      log.error "Error: #{e.message}"
    end

    private

    ##
    # Ensure valid credentials, either by restoring from the saved credentials
    # files or intitiating an OAuth2 authorization. If authorization is required,
    # the user's default browser will be launched to approve the request.
    #
    # @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
    def authorize
      config = YAML.load_file File.join(__dir__, "../../config.yml")
      FileUtils.mkdir_p File.dirname File.join("#{ENV["HOME"]}/.toggl_integrator/google-calendar.yaml")

      client_id   = Google::Auth::ClientId.from_file ENV["CLIENT_SECRET_FILE"]
      token_store = Google::Auth::Stores::FileTokenStore.new file: File.join("#{ENV["HOME"]}/.toggl_integrator/google-calendar.yaml")
      authorizer  = Google::Auth::UserAuthorizer.new client_id, Google::Apis::CalendarV3::AUTH_CALENDAR, token_store
      user_id     = "default"
      credentials = authorizer.get_credentials user_id
      if credentials.nil?
        url = authorizer.get_authorization_url base_url: config["google"]["oob_uri"]

        info_message = "Open the following URL in the browser and enter the " +
                       "resulting code after authorization\n\n" +
                       "URL: #{url}\n\n" +
                       "Got resulting code? Please input your resulting code"
        Logger.new("#{ENV["HOME"]}/.toggl_integrator/log").info info_message
        puts info_message
        code = gets
        credentials = authorizer.get_and_store_credentials_from_code user_id: user_id, code: code, base_url: config["google"]["oob_uri"]
      end
      credentials
    rescue => e
      Logger.new("#{ENV["HOME"]}/.toggl_integrator/log").error "Error: #{e.message}"
    end
  end

end
