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
    book = Book.find_by(summoner_id: summoner_id)
    if !book then
      book = Book.create_from_summoner(RiotApi.summoner_by_id(summoner_id))
    end

    respond_to do |format|
      format.html do
        if @book = Book.includes(champions: [:static_data], comments: [:author, :votes]).find(book.id) then
          render "books/show"
        else
          render "shared/not_found"
        end
      end

      format.js do
        if @comments = book.comments.includes(:author, :votes).paginate(page: params[:page]) then
          render "comments/paginate"
        else
          render nothing: true
        end
      end
    end
  end

  def update
    summoner_id =  params[:summoner_id]
    respond_to do |format|
      if book = Book.find_by(summoner_id: summoner_id) then
        book.update_summoner(RiotApi.summoner_by_id(summoner_id))
        book.update_champions(RiotApi.champion_mastery(summoner_id))
        flash[:success] = 'Yearbook now up to date.'
        format.json {render json: true, status: :ok}
        format.html {redirect_to action: :show}
      else
        message = "An error occurred. Yearbook not updated"
        flash[:warning] = message
        format.json {render text: message, status: :internal_server_error}
        format.html {render "shared/not_found"}
      end
    end
    #TODO ^more descriptive error handling..
  end

  private
  def search_params
    params.require(:summoner_name)
  end
end
