class ChampionsController < ApplicationController
  def index
    respond_to do |format|
      format.html {redirect_to book_path(params[:region], params[:summoner_id])}
      format.js do
        book = Book.find_by(summoner_id: params[:summoner_id])
        @champions = Champion.includes(:static_data, comments: [:author, :votes]).where(book_id: book.id, mastery_level: params[:filter])
        render "champions/index"
      end
    end
  end

  def show
    book = Book.find_by(summoner_id: params[:summoner_id])
    champion = Champion.find_by(book_id: book.id, champion_id: params[:champion_id])
    respond_to do |format|
      format.html do
        if champion then
          @champion = Champion.includes(:static_data, comments: [:author, :votes]).find(champion.id)
          render "champions/show"
        else
          render "shared/not_found"
        end
      end
      format.js do
        if champion then
          @comments = champion.comments.includes(:author, :votes).paginate(page: params[:page])
          render "comments/paginate"
        else
          render nothing: true
        end
      end
    end
  end
end
