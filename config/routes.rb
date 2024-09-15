Rails.application.routes.draw do
  resources :users, :companies
  get 'csv_output', to: 'users#csv_output'
  get 'send_slack_notification', to: 'slacks#send_slack_notification'
  get 'notify_slack_with_links', to: 'slacks#notify_slack_with_links'
  get 'notify_slack_with_blocks', to: 'slacks#notify_slack_with_blocks'
end
