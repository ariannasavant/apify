JsonRoutes::Engine.routes.draw do
  root to: 'application#index'
  get '/resources' => 'application#index'
  get '/info' => 'application#info'
end
