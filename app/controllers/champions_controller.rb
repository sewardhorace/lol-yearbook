class ChampionsController < ApplicationController
  def show
    book = Book.find_by(summoner_id: params[:summoner_id])
    @champion = Champion.find_by(book_id: book.id, champion_id: params[:champion_id])
    render "champions/show"
  end
end
