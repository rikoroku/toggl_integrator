# frozen_string_literal: true

# config: utf-8

require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

module TogglIntegrator
  # class GoogleCalendar
  class GoogleCalendar
    def sync(time_entry)
      service.insert_event 'primary', generate_event(time_entry),
                           send_notifications: true
    end

    private

    def service
      @service ||= authorized_service
    end

    def config
      @config ||= YAML.load_file File.join(__dir__, '../../../config.yml')
    end

    def generate_event(time_entry)
      {
        summary: "#{time_entry[:project_name]} : #{time_entry[:description]}",
        start: {
          date_time: DateTime.parse(time_entry[:start].localtime.to_s)
        },
        end: {
          date_time: DateTime.parse(time_entry[:stop].localtime.to_s)
        },
        color_id: ENV['COLOR_ID']
      }
    end

    def authorizer
      return @authorizer if @authorizer.present?

      client_id   = Google::Auth::ClientId.from_file ENV['CLIENT_SECRET_FILE']
      token_store = Google::Auth::Stores::FileTokenStore.new file:
        FileUtil.join('google-calendar.yaml')
      @authorizer = Google::Auth::UserAuthorizer.new client_id,
                                                     Google::Apis::CalendarV3::\
                                                     AUTH_CALENDAR,
                                                     token_store
    end

    def authorized_service
      service = Google::Apis::CalendarV3::CalendarService.new
      service.client_options.application_name =
        config['google']['application_name']
      service.authorization = credentials
      service
    end

    def credentials
      return @credentials if @credentials.present?

      FileUtil.new_file_if_not_exists('google-calendar.yaml')

      @credentials = authorizer.get_credentials user_id
      @credentials = credentials_from_code if @credentials.nil?
      @credentials
    end

    def user_id
      @user_id ||= 'default'
    end

    def credentials_from_code
      url = authorizer.get_authorization_url base_url:
        config['google']['oob_uri']

      info_message = 'Open the following URL in the browser and enter the ' \
                    "resulting code after authorization\n\n URL: #{url}\n\n" \
                    'Got resulting code? Please input your resulting code'
      puts info_message
      code = gets
      authorizer.get_and_store_credentials_from_code user_id:
        user_id, code: code, base_url: config['google']['oob_uri']
    end
  end
end
