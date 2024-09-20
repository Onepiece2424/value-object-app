class SlacksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:send_easy_message, :events, :file_upload]

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

  def events
    if params[:token] == ENV['SLACK_VERIFICATION_TOKEN']
      case params[:type]
      when 'url_verification'
        render plain: params[:challenge]
      when 'event_callback'
        handle_event(params[:event])
        head :ok
      end
    else
      head :bad_request
    end
  end

  def file_upload
    notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'])
    file = params[:file].tempfile # アップロードされたファイルの一時ファイル
    filename = params[:file].original_filename # 元のファイル名
    uploader = SlackFileUploader.new(ENV['SLACK_API_TOKEN'])
    file_url = uploader.upload_file(file.read, filename)
    text = SlackFormat.file_upload_format(file_url)
    notifier.post(blocks: text)
    render json: { message: "File uploaded successfully", file_url: file_url }, status: :ok
  end

  private

  def handle_event(event)
    return if event[:text] == "応答ありがとうございます！" || event[:subtype].present?

    user = event[:user]
    text = event[:text]
    thread_ts = event[:thread_ts] || event[:ts] # 元のメッセージのthread_tsがある場合、それを使う

    # スタンドアップの応答を保存
    StandupResponse.create(user: user, response: text)

    # スレッド内で返信する
    SLACK_CLIENT.chat_postMessage(
      channel: event[:channel],
      text: "応答ありがとうございます！",
      thread_ts: thread_ts, # スレッド内に返信
      as_user: true
    )
  end
end
