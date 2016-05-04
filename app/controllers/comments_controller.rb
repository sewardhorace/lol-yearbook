class CommentsController < ApplicationController
  def new_book_comment
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

  def new_champion_comment
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

  def delete_comment

  end

  private
  def comment_params
    params.require(:comment).permit(:text, :id)
  end
end
