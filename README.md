# Toggl Integrator
[toggl_integrator](https://github.com/rikoroku/toggl_integrator) is an Integrator for Toggl to Google Calendar.

## Installation

Add this line to your Gemfile:

```ruby
gem "togglv8", :git => "https://github.com/kanet77/togglv8", :branch => "master"
gem "toggl_integrator", :git => "https://github.com/rikoroku/toggl_integrator", :branch => "master"
```

And then execute:

    $ bundle install

## Usage
### 1. 1st time only
#### 1-1. Set environment variable.
#### 1-1-1. Toggl
You need to get toggl API token.
About API token: Each user in [Toggl.com](https://www.toggl.com/) has an API token. They can find it under "My Profile" in their Toggl account.

```
$ export TOGGL_API_TOKEN="Your api token"
```

#### 1-1-2. Google Calendar
You need to turn on the Google Calendar API and get client_secret.json.

About turn on the Google Calendar API and get client_secret.json:

1. Use this [wizard](https://console.developers.google.com/start/api?id=calendar) to create or select a project in the Google Developers Console and automatically turn on the API. Click *Continue*, then *Go to credentials*.
2. On the *Add credentials to your project* page, click the *Cancel* button.
3. At the top of the page, select the *OAuth consent screen* tab. Select an *Email address*, enter a Product name if not already set, and click the *Save* button.
4. Select the *Credentials* tab, click the *Create credentials* button and select *OAuth client ID*.
5. Select the application type *Other*, enter the name "toggl_integrator", and click the Create button.
6. Click *OK* to dismiss the resulting dialog.
7. Click the (Download JSON) button to the right of the client ID.
8. Move this file to your working directory and rename it `client_secret.json`.

```
$ export CLIENT_SECRET_FILE="Your client_secret.json path"
$ source ~/.bash_profile
```

#### 1-2. Authorization
The authorization procedure is as follows.

```
$ bundle exec toggl_integrator

Open the following URL in the browser and enter the resulting code after authorization

URL: https://xxxx/

Got resulting code? Please input your resulting code
```

### 2. default

```
$ bundle exec toggl_integrator
```

#### 2-1. Schedule toggl_integrator as a cronjob
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
