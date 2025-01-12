Rails.application.routes.draw do
  resources :applies do
    resources :files, controller: 'apply_files'
    
  end
  
  post "applies/upload_file", to: "applies#upload_file"
# config/routes.rb
  delete '/applies/:apply_id/attachments/:blob_id', to: 'applies#destroy_attachment', as: 'destroy_attachment'
  
  get '/applies/:apply_id/departments_by_year', to: 'applies#departments_by_year'

  get '/apply_data_tabs/all_departments_by_year', to: 'apply_data_tabs#all_departments_by_year'

  resources :bosses

  resources :apply_data_tabs

  
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :tests
  resources :departments do
    collection { post :import }
  end
  resources :years
  resources :admin_users

  get '/search', to: 'application#search'

  get    'data_upload'          => 'departments#index'
  post   'data_upload'          => 'departments#create'
  get 'departments/:year/export_csv', to: 'departments#export_csv', as: 'export_csv_departments'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "applies#index"
end
