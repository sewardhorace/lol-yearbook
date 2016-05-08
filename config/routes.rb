Rails.application.routes.draw do

  root 'welcome#index'
  get '/search', to: 'books#search'

#books
  get '/summoner/:summoner_id', to: 'books#show', as: 'book'
  post '/summoner/:summoner_id', to: 'books#update', as: 'update_book'

#champions
  get '/summoner/:summoner_id/champion/:champion_id', to: 'champions#show', as: 'champion'
  get '/summoner/:summoner_id/champions', to: 'champions#index', as: 'champions'

#comments
  post '/comment', to: 'comments#new', as: 'new_comment'
  delete '/comment', to: 'comments#destroy', as: 'delete_comment'
  put '/comment/vote', to: 'comments#vote', as: 'vote'

#sessions
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
