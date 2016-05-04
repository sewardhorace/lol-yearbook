class CommentsController < ApplicationController
  def new_book_comment
    comment = BookComment.create(
      book_id: comment_params[:id],
      text: comment_params[:text],
      user_id: current_user.id
    )
    handle_new_comment_response(comment)
  end

  def new_champion_comment
    comment = ChampionComment.create(
      champion_id: comment_params[:id],
      text: comment_params[:text],
      user_id: current_user.id
    )
    handle_new_comment_response(comment)
  end

  def handle_new_comment_response(comment)
    if comment.valid? then
      render json: comment, status: :created
    elsif !current_user then
      render text: "You must log in to comment", status: :unauthorized
    else
      render text: "Comment could not be created", status: :unprocessable_entity
    end
  end

  def destroy
    if @comment = Comment.find_by(id: params[:id], user_id: current_user.id) then
      @comment.delete
      render 'comments/destroy', status: :ok
    elsif !current_user then
      render text: "You must be logged in as the comment author to delete a comment", status: :unauthorized
    else
      render text: "Comment could not be deleted", status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :id)
  end
end
