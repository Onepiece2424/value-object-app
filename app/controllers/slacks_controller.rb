class SlacksController < ApplicationController
  def send_slack_notification
    notifier = Slack::Notifier.new(
      ENV['SLACK_WEBHOOK_URL'],
      channel: "##{ENV['SLACK_CHANNEL']}",
      username: '通知です'
    )
    notifier.ping '通知テキスト'
  end
end
