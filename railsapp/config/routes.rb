Rails.application.routes.draw do
  resources :applies
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

get '/search', to: 'application#search'

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "applies#index"
end
