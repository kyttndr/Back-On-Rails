Rails.application.routes.draw do
  mount Notifications::Engine => "/notifications"
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    resources :profiles
    resources :user_reviews
  end

  get 'borrow_transactions', to: 'transactions#borrow_index'
  get 'lend_transactions', to: 'transactions#lend_index'
  get 'pending_transactions', to: 'transactions#pending_index'
  get 'borrow_transactions_history', to: 'transactions#borrow_history_index'
  get 'lend_transactions_history', to: 'transactions#lend_history_index'
  resources :transactions

  resources :items do
      resources :item_reviews
  end

  #item search
  get 'search_items', to: 'items#search'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  #For friends
  resources :friendships
  get 'my_friends', to: 'users#my_friends'
  get 'search_friends', to: 'users#search'
  post 'add_friend', to: 'users#add_friend'
  

  resources :places #except: [:update, :edit, :destroy]

  get 'show_items', to: 'items#show_items'

  root "welcome#index"

end
