ConveyUser::Engine.routes.draw do
  get '/login', to: 'ConveyUser/sessions#new'
  get '/auth/:provider/callback', to: 'ConveyUser/sessions#create'

  post '/webhooks/convey', to: 'ConveyUser/webhooks#catch'
end
