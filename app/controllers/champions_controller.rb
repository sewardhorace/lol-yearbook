class ChampionsController < ApplicationController
  def index
    respond_to do |format|
      format.html {redirect_to book_path(params[:summoner_id])}
      format.js do
        book = Book.find_by(summoner_id: params[:summoner_id])
        @champions = Champion.where(book_id: book.id, mastery_level: params[:filter])
        render "champions/index"
      end
    end
  end

  def show
    book = Book.find_by(summoner_id: params[:summoner_id])
    @champion = Champion.find_by(book_id: book.id, champion_id: params[:champion_id])
    respond_to do |format|
      if @champion then
        format.html {render "champions/show"}
        format.js do
          @comments = @champion.comments.paginate(page: params[:page])
          render "comments/paginate"
        end
      else
        format.html {render "shared/not_found"}
      end
    end
  end
end
