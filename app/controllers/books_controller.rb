class BooksController < ApplicationController
  def search
    if summoner = RiotApi.summoner_by_name(search_params) then
      redirect_to book_path(summoner['id'])
    else
      raise ActionController::RoutingError.new('Not Found')
      #TODO actually create a 404 page
    end
  end

  def show
    @champions = RiotApi.champions_mastery(params[:summoner_id])
    #this is bad because it creates a new record for any id, not just valid ones...
    #also, the api currently needs to be called once to get the summoner id from the name, then again to get the name from the id...
    if @book = Book.find_by(summoner_id: params[:summoner_id])
      render "books/show"
    else
      #@book = Book.create(summoner_id: params[:summoner_id])
      render "books/show"
    end
  end

  private
    def search_params
      params.require(:summoner_name)
    end
end
