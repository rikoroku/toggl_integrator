[![Build Status](https://travis-ci.org/rikoroku/toggl_integrator.svg?branch=master)](https://travis-ci.org/rikoroku/toggl_integrator)
[![Maintainability](https://api.codeclimate.com/v1/badges/5debd001c75ec6ad575a/maintainability)](https://codeclimate.com/github/rikoroku/toggl_integrator/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/5debd001c75ec6ad575a/test_coverage)](https://codeclimate.com/github/rikoroku/toggl_integrator/test_coverage)

[toggl_integrator](https://github.com/rikoroku/toggl_integrator) is an Integrator that integrate toggl reports into Google Calendar.

## Installation

Add the following line to your Gemfile:

```ruby
gem "toggl_integrator", :git => "https://github.com/rikoroku/toggl_integrator", :branch => "master"
```

And then execute:

    $ bundle install

## Setup

### 1. Set environment variables.

#### Toggl

You need to get a toggl API token and can get the toggl API token from bottom of [Your profile page](https://www.toggl.com/app/profile).

When you have got the toggl API token, write it to `.env`

```bash:.env
TOGGL_API_TOKEN='your toggl API token'
```

#### Google Calendar

You need to turn on the Google Calendar API and get client_secret.json.

About turn on the Google Calendar API and get client_secret.json:

1. Use this [wizard](https://console.developers.google.com/start/api?id=calendar) to create or select a project in the Google Developers Console and automatically turn on the API. Click _Continue_, then _Go to credentials_.
2. On the _Add credentials to your project_ page, click the _Cancel_ button.
3. At the top of the page, select the _OAuth consent screen_ tab. Select an _Email address_, enter a Product name if not already set, and click the _Save_ button.
4. Select the _Credentials_ tab, click the _Create credentials_ button and select _OAuth client ID_.
5. Select the application type _Other_, enter the name "toggl_integrator", and click the Create button.
6. Click _OK_ to dismiss the resulting dialog.
7. Click the (Download JSON) button to the right of the client ID.
8. Move this file to your working directory and rename it `client_secret.json`.

When you have got the client_secret.json, write it to `.env`

```bash:.env
CLIENT_SECRET_FILE='/Users/username/Documents/.secret/client_secret.json'
```

#### Other

Follow the instructions below to set other variables to '.env'

```bash:.env
# Specify toggl_integrator project directory that will be automatically generated. This directory includes a log file and SQL data.
PROJECT_PATH='/Users/username/Documents/'

# The COLOR_ID is a color of the event when integrated Google Calendar. If you want to know the id? You can do it from follows.
# URL: https://developers.google.com/calendar/v3/reference/colors/get
COLOR_ID='8'
```

### 2. Authorization

The authorization steps are as follows.

```
$ bundle exec toggl_integrator

Open the following URL in the browser and enter the resulting code after authorization

URL: https://xxxx/

Got resulting code? Please input your resulting code
```

## Usage

```
$ bundle exec toggl_integrator
```

### Schedule toggl_integrator as a cronjob

For example:

```
$ crontab -e
*/15 * * * * /bin/bash -lc 'bundle exec toggl_integrator' > /dev/null 2>&1
```

## Contributing

1. Fork it ( https://github.com/rikoroku/toggl_integrator )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Bug reports and pull requests are welcome.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
