Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  # ログイン機能
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :bases
  resources :users do
    collection { post :import }
    collection { get :go_work }
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
      get 'attendances/working'
      get 'attendances/request_overtime'
      patch 'attendances/update_overtime'
    end
    
      
    resources :attendances, only: :update
    end
  
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
