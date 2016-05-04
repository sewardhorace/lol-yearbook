Rails.application.routes.draw do

  root 'welcome#index'
  get '/search', to: 'books#search'

#books
  get '/summoner/:summoner_id', to: 'books#show', as: 'book'
  post '/summoner/:summoner_id/update', to: 'books#update', as: 'update_book'

#champions
  get '/summoner/:summoner_id/champion/:champion_id', to: 'champions#show', as: 'champion'

#comments
  post '/comment/summoner', to: 'comments#new_book_comment', as: 'new_book_comment'
  post '/comment/champion', to: 'comments#new_champion_comment', as: 'new_champion_comment'
  delete '/comment/:id', to: 'comments#destroy', as: 'delete_comment'

#sessions
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
