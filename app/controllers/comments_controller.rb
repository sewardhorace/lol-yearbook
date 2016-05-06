class CommentsController < ApplicationController
  def new
    @comment = Comment.create_from_type(comment_params)
    respond_to do |format|
      format.js do
        if @comment.valid? then
          render "comments/new", status: :created
        elsif !current_user then
          render text: "You must log in to comment", status: :unauthorized
        else
          render text: "Comment could not be created", status: :unprocessable_entity
        end
      end
      format.html {redirect_to root_path}
    end
  end

  def destroy
    if @comment = Comment.find_by(id: comment_params[:id], user_id: comment_params[:user_id]) then
      render json: @comment.delete, status: :ok
    elsif !current_user then
      render text: "You must be logged in as the comment author to delete a comment", status: :unauthorized
    else
      render text: "Comment could not be deleted", status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :id, :type).merge(user_id: current_user.id)
  end
end
