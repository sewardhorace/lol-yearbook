class BooksController < ApplicationController
  def search
    if summoner = RiotApi.summoner_by_name(search_params) then
      redirect_to book_path(summoner['id'])
    else
      render "shared/not_found"
    end
    #TODO more descriptive than '404'
  end

  def show
    summoner_id = params[:summoner_id]
    if @book = Book.find_by(summoner_id: summoner_id) then
      respond_to do |format|
        format.html {render "books/show"}
        format.js do
          @comments = @book.comments.paginate(page: params[:page])
          render "comments/paginate"
        end
      end
    elsif summoner = RiotApi.summoner_by_id(summoner_id) then
      @book = Book.create(
        summoner_id: summoner["id"],
        summoner_name: summoner["name"]
      )
      render "books/show"
    else
      render "shared/not_found"
    end
  end

  def update
    summoner_id =  params[:summoner_id]
    book = Book.find_by(summoner_id: summoner_id)
    book.update_summoner(RiotApi.summoner_by_id(summoner_id))
    if book.update_champions(RiotApi.champion_mastery(summoner_id)) then
      flash[:success] = 'Yearbook now up to date.'
      render json: true, status: :ok
    else
      message = "An error occurred. Yearbook not updated"
      flash[:warning] = message
      render text: message, status: :internal_server_error
    end
    #TODO ^more descriptive error handling..
  end

  private
  def search_params
    params.require(:summoner_name)
  end
end
