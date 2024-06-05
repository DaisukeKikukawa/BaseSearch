Rails.application.routes.draw do
  root to: 'top#index'

  get 'games', to: 'games#index'
  get 'games/calendar', to: 'games#calendar'
  resources :games, only: [:index, :show]
  resources :teams, only: [:show] do
    resources :players, only: [:index]
    get '/games', to: 'games#index', as: 'games'
    get '/games/calendar', to: 'games#calendar'
  end
  resources :tournaments, only: [:index, :show] do
    get '/games', to: 'games#index', as: 'games'
    get '/games/calendar', to: 'games#calendar'
  end
  get 'top', to: 'top#index'
  get 'grounds', to: 'grounds#index'
  get 'team_search', to: 'team_search#index'
  get 'team_search/search', to: 'team_search#search'
  # devise_for :admin_users, controllers: {
  #   sessions: 'admin_users/sessions'
  # }

end
