Rails.application.routes.draw do
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    resources :profiles

    get 'pending_transactions', to: 'transactions#pending_transactions_index'
    resources :transactions
  end
  resources :items do
      resources :transactions
  end

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'

  root "welcome#index"

end
