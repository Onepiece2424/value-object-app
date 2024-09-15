require 'slack-ruby-client'

Slack.configure do |config|
  config.token = ENV['SLACK_BOT_TOKEN']
end

SLACK_CLIENT = Slack::Web::Client.new
