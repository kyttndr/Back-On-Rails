Rails.application.routes.draw do
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    resources :profiles
  end

  get 'borrow_transactions', to: 'transactions#borrow_index'
  get 'lend_transactions', to: 'transactions#lend_index'
  get 'pending_transactions', to: 'transactions#pending_index'
  get 'borrow_transactions_history', to: 'transactions#borrow_history_index'
  get 'lend_transactions_history', to: 'transactions#lend_history_index'
  resources :transactions

  resources :items

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  root "welcome#index"

end
