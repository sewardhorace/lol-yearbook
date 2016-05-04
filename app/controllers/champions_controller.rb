class ChampionsController < ApplicationController
  def show
    book = Book.find_by(summoner_id: params[:summoner_id])
    @champion = Champion.find_by(book_id: book.id, champion_id: params[:champion_id])
    render "champions/show"
  end

  def new_comment
    comment = ChampionComment.create(
      champion_id: comment_params[:id],
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

  private
  def comment_params
    params.require(:comment).permit(:text, :id)
  end
end
