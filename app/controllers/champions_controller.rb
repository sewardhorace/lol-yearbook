class ChampionsController < ApplicationController
  def show
    book = Book.find_by(summoner_id: params[:summoner_id])
    @champion = Champion.find_by(book_id: book.id, champion_id: params[:champion_id])
    respond_to do |format|
      format.html {render "champions/show"}
      format.js do
        @comments = @champion.comments.paginate(page: params[:page])
        render "comments/paginate"
      end
    end
  end
end
