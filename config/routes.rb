Rails.application.routes.draw do
  root 'products#index'
  resources :users, only: %i[index show], param: :screen_name
  resource :profile, only: %i[show edit update destroy]
  resources :products do
    resources :images, only: %i[new create edit update destroy]
    resources :media, only: %i[new create edit update destroy]
  end

  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  # 開発/テスト用ログイン
  get '/login_as/:user_id', to: 'development/sessions#login_as' unless Rails.env.production?
end
