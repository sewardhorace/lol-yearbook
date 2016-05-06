class Comment < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  validates :user_id, presence: true
  validates :text, presence: true

  self.per_page = 10

  def self.create_from_type(params)
    type = params[:type]
    if type == "ChampionComment" then
      comment = ChampionComment.create(
        champion_id: params[:id],
        text: params[:text].strip,
        user_id: params[:user_id]
      )
    elsif type == "BookComment" then
      comment = BookComment.create(
        book_id: params[:id],
        text: params[:text].strip,
        user_id: params[:user_id]
      )
    else
      comment = Comment.create(
        user_id: nil
      )
    end
    return comment
  end

  def time
    return time_ago_in_words(self.created_at)
  end
end
