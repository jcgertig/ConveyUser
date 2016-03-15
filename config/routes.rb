ConveyUser::Engine.routes.draw do
  get '/login', to: 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#create'

  post '/webhooks/convey', to: 'webhooks#catch'
end
