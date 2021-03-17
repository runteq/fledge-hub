Rails.application.routes.draw do
  root 'static_pages#top'

  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  # 開発/テスト用ログイン
  get '/login_as/:user_id', to: 'development/sessions#login_as' unless Rails.env.production?
end
