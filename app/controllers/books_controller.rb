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
    summoner_id = params[:summoner_id]
    if @book = Book.find_by(summoner_id: summoner_id) then
      render "books/show"
    elsif summoner = RiotApi.summoner_by_id(summoner_id) then
      @book = Book.create(
        summoner_id: summoner["id"],
        summoner_name: summoner["name"]
      )
      render "books/show"
    else
      raise ActionController::RoutingError.new('Not Found')
      #TODO actually create a 404 page
    end
  end

  def update
    summoner_id =  params[:summoner_id]
    book = Book.find_by(summoner_id: summoner_id)
    book.update_summoner(RiotApi.summoner_by_id(summoner_id))
    book.update_champions(RiotApi.champion_mastery(summoner_id))
    #TODO ^needs error handling.. what if RiotApi call fails for some reason?
    # redirect_to book_path(summoner_id)
    #^ reloads page in ajax call
    render json: true, status: :ok
  end

  def new_comment
    comment = BookComment.create(
      book_id: comment_params[:id],
      text: comment_params[:text],
      user_id: current_user.id
    )
    if comment.valid? then
      render json: comment, status: :created
    elsif !current_user then
      render text: "You must log in to comment", status: :unauthorized
    else
      render text: "Comment could not be created", status: :unprocessable_entity
    end
  end

  def delete_comment
    
  end

  private
  def search_params
    params.require(:summoner_name)
  end

  def comment_params
    params.require(:comment).permit(:text, :id)
  end
end
