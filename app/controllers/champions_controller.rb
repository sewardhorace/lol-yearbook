class ChampionsController < ApplicationController
  def show
    puts "SHOW CHAMPION"
    book = Book.find_by(summoner_id: params[:summoner_id])
    puts book
    @champion = Champion.find_by(book_id: book.id, champion_id: params[:champion_id])
    puts @champion
    render "champions/show"
  end
end
