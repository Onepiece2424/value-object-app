namespace :standup do
  desc "Send standup questions to Slack users"
  task send_questions: :environment do
    # SlackのチャンネルID、またはユーザーID
    channel = '#general'

    # スタンドアップ質問メッセージを送信
    SLACK_CLIENT.chat_postMessage(
      channel: channel,
      text: "おはようございます！今日のスタンドアップの質問に答えてください。\n1. 昨日何をやりましたか？\n2. 今日何をしますか？\n3. 課題や障害はありますか？",
      as_user: true
    )
  end
end
