Rails.application.routes.draw do

  mount Notifications::Engine => "/notifications"
  mount Crono::Web, at: '/crono'

  get 'welcome/index'
  get 'welcome/about', to: 'welcome#about'
  get 'welcome/privacy_policy', to: 'welcome#privacy_policy'
  get 'welcome/faq', to: 'welcome#faq'
  get 'welcome/contact_us', to: 'welcome#contact_us'
  get 'welcome/terms_of_service', to: 'welcome#terms_of_service'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    resources :profiles
    resources :user_reviews
  end

  # Account activation routing
  resources :account_activations, only: [:edit]

  # Password reset routing
  resources :password_resets, only: [:new, :create, :edit, :update]

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
  get 'listed_items', to: 'items#listed_items'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  #For friends
  resources :friendships
  get 'my_friends', to: 'users#my_friends'
  get 'my_followers', to: 'users#my_followers'
  get 'search_friends', to: 'users#search'
  post 'add_friend', to: 'users#add_friend'
  post 'add_follower', to: 'users#add_follower'


  resources :places #except: [:update, :edit, :destroy]
  get 'my_places', to: 'users#my_places'

  get 'show_items', to: 'items#show_items'

  #for admin
  get 'manage_website', to: 'users#manage_website'
  get 'remove_admin', to: 'users#remove_admin'
  get 'add_admin', to: 'users#add_admin'
  get 'setup_admin', to: 'users#setup_admin'
  get 'ini', to: 'users#ini'

  resources :tags

  root 'welcome#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

end
