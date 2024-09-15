Rails.application.routes.draw do
  resources :users, :companies
  get 'csv_output', to: 'users#csv_output'
end
