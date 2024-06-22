Rails.application.routes.draw do
  root to: 'top#index'

  get 'games', to: 'games#index'
  get 'games/calendar', to: 'games#calendar'
  resources :games, only: [:index, :show]
  resources :teams, only: [:show] do
    resources :players, only: [:index]
    get '/games', to: 'games#index', as: 'games'
    get '/games/calendar', to: 'games#calendar'
    get '/wordpress_articles', to: 'wordpress_articles#index'
  end
  resources :tournaments, only: [:index, :show] do
    get '/games', to: 'games#index', as: 'games'
    get '/games/calendar', to: 'games#calendar'
  end
  get 'top', to: 'top#index'
  get 'grounds', to: 'grounds#index'
  get 'team_search', to: 'team_search#index'
  get 'team_search/search', to: 'team_search#search'
  devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions'
  }

  # ------------------ CMS ------------------ #
  namespace :admin do
    resources :tournament_records
    resources :grounds
    resources :tournaments
    resources :teams
    resources :team_categories
    resources :players
    resources :games do
      resources :articles
    end
    resources :union_teams
    get 'dashboard/index'
  end
  # Slug同期ボタン
  # post 'fetch_slugs', to: 'fetch#fetch_slugs'
  # post 'fetch_wp_articles', to: 'fetch#fetch_wp_articles'
  post 'fetch_slugs_and_wp_articles', to: 'fetch#fetch_slugs_and_articles'

  # ------------------ health_check ------------------ #
  get 'health_check', to: 'health_check#index'

  # ------------------ error ------------------ #
  get 'not_found', to: 'errors#not_found'
  get 'internal_server_error', to: 'errors#internal_server_error'

  if Rails.env.production? || Rails.env.staging?
    # すべての未知のルートを404エラーページへリダイレクト
    match '*path', to: 'errors#not_found', via: :all, constraints: lambda { |req|
      # 'rails/active_storage'が含まれているパスはリダイレクト対象外にする
      req.path.exclude? 'rails/active_storage'
    }
  end
end
