require 'net/http'
require 'json'
require 'uri'

class SlackFileUploader
  SLACK_API_URL = 'https://slack.com/api/'

  def initialize(oauth_token)
    @oauth_token = oauth_token
  end

  # ファイルをアップロードする
  def upload_file(file_blob, filename)
    upload_url, file_id = get_file_upload_url(filename, file_blob.size)

    # ファイルをPOSTで送信
    response = post_file(upload_url, file_blob)
    puts response.body

    complete_file_upload(file_id)
    get_file_permalink(file_id)
  end

  private

  # ファイルアップロード用URLを取得する
  def get_file_upload_url(filename, length)
    uri = URI("#{SLACK_API_URL}files.getUploadURLExternal")

    # GETリクエストにパラメータをクエリ文字列として追加する
    uri.query = URI.encode_www_form({
      'filename' => filename,
      'length' => length.to_s
    })

    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "Bearer #{@oauth_token}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    data = JSON.parse(response.body)
    unless data['ok']
      raise "Error fetching upload URL: #{data}"
    end

    [data['upload_url'], data['file_id']]
  end

  # ファイルをPOSTでアップロード
  def post_file(upload_url, file_blob)
    uri = URI(upload_url)
    request = Net::HTTP::Post.new(uri)
    request.body = file_blob

    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  end

  # アップロード処理を完了する
  def complete_file_upload(file_id)
    uri = URI("#{SLACK_API_URL}files.completeUploadExternal")
    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = "Bearer #{@oauth_token}"
    request['Content-Type'] = 'application/json'
    request.body = { files: [{ id: file_id }] }.to_json

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    data = JSON.parse(response.body)
    unless data['ok']
      raise "Error completing file upload: #{data}"
    end
  end

  # ファイルのURLを取得する
  def get_file_permalink(file_id)
    uri = URI("#{SLACK_API_URL}files.info")

    # GETリクエストにパラメータをクエリ文字列として追加する
    uri.query = URI.encode_www_form({ 'file' => file_id })

    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "Bearer #{@oauth_token}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    data = JSON.parse(response.body)
    unless data['ok']
      raise "Error fetching file permalink: #{data}"
    end

    data['file']['permalink']
  end
end
