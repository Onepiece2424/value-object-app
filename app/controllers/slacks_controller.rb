class SlacksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:send_easy_message]

  def send_slack_notification
    notifier = SlackNotifier.new
    notifier.send("通知テキスト")
  end

  def notify_slack_with_links
    # SlackのWebhook URLを設定
    notifier = SlackNotifier.new

    # 通知メッセージの内容
    message = "<!channel> こんにちは！ [クリックしてね](https://github.com/slack-notifier/slack-notifier)"

    # メッセージ内のリンクをSlack形式に変換
    formatted_message = Slack::Notifier::Util::LinkFormatter.format(message)

    # Slackに通知を送信
    notifier.send(formatted_message)
  end

  def notify_slack_with_blocks
    # SlackのWebhook URLを設定
    notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'])

    # 通知するためのブロック形式のデータ
    blocks = [
      {
        "type": "image",
        "title": {
          "type": "plain_text",
          "text": "image1",
          "emoji": true
        },
        "image_url": "https://api.slack.com/img/blocks/bkb_template_images/onboardingComplex.jpg",
        "alt_text": "image1"
      },
      {
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": "Hey there 👋 I'm TaskBot. I'm here to help you create and manage tasks in Slack.\nThere are two ways to quickly create tasks:"
        }
      }
    ]

    # Slackにブロック形式のメッセージを送信
    notifier.post(blocks: blocks)
  end

  def send_easy_message
    message = params[:message]
    notifier = SlackNotifier.new
    notifier.send(message)
    render json: { status: 'Message sent to Slack successfully' }
    rescue => e
      render json: { status: 'Error sending message to Slack', error: e.message }, status: :unprocessable_entity
  end
end
