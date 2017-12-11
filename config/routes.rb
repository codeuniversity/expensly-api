Rails.application.routes.draw do
  resources :articles do
    resources :items, module: "articles", only: [:index, :create]
  end
  resources :categories do
    resources :articles, module: "categories", only: [:index, :create]
  end
  resources :items
  resources :transactions do
    resources :items, module: "transactions", only: [:index, :create]
  end
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
