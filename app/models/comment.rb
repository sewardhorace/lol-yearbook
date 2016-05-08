class Comment < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  has_many :votes, dependent: :destroy
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

  def score
    votes = self.votes
    return votes.up.count - votes.down.count
  end

  def upvote(voter_id)
    vote_for_voter(voter_id).update(flag: true)
  end

  def downvote(voter_id)
    vote_for_voter(voter_id).update(flag: false)
  end

  def unvote(voter_id)
    vote_for_voter(voter_id).update(flag: nil)
  end

  private
  def vote_for_voter(voter_id)
    Vote.find_or_create_by(comment_id: self.id, user_id: voter_id)
  end
end
