Rails.application.routes.draw do
  resources :users, :companies
  get 'csv_output', to: 'users#csv_output'
  get 'send_slack_notification', to: 'slacks#send_slack_notification'
end
