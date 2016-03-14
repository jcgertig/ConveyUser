Rails.application.routes.draw do
  get '/login', to: 'convey_user/sessions#new'
  get '/auth/:provider/callback', to: 'convey_user/sessions#create'

  post '/webhooks/convey', to: 'convey_user/webhooks#catch'
end
