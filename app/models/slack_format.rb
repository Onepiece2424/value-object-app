class SlackFormat
  class << self
    def file_upload_format(file_url)
      # 通知するためのブロック形式のデータ
      blocks = [
        {
          "type": "image",
          "title": {
            "type": "plain_text",
            "text": "image1",
            "emoji": true
          },
          "image_url": file_url,
          "alt_text": "image1"
        },
        {
          "type": "section",
          "text": {
            "type": "mrkdwn",
            "text": "やぁ!✨僕はTaskBotだよ🦸‍♂️ タスクを作成して、Slackでバリバリ管理できるようにサポートするよ!💪🚀\nタスクをシュッと作成するには、2つのスマートな方法があるんだよ👇😉:"
          }
        }
      ]
      end
  end
end
