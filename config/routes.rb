Rails.application.routes.draw do
  root 'products#index'
  resources :users, only: %i[index show], param: :screen_name
  resource :mypage, only: %i[show]
  namespace :settings do
    resource :profile, only: %i[show update]
    resources :social_accounts, only: %i[index] do
      collection do
        put '', action: :upsert_all
      end
    end
  end
  resource :registration, only: %i[new create]
  resource :user_deactivation, only: %i[new destroy]
  resources :products do
    resources :product_images, only: %i[new create edit update destroy]
    resources :product_media, only: %i[new create edit update destroy]
  end

  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  # 開発/テスト用ログイン
  get '/login_as/:user_id', to: 'development/sessions#login_as' unless Rails.env.production?
end
