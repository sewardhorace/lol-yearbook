class User < ActiveRecord::Base
  has_many :comments
  has_many :votes

  def self.from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.update(
      name: auth_hash['info']['name'],
      img_url: auth_hash['info']['image'],
      url: auth_hash['info']['urls']['Twitter']
    )
    return user
  end

  def upvoted?(comment_id)
    if vote = vote_for_comment(comment_id) then
      return vote.flag == true
    else
      false
    end
  end

  def downvoted?(comment_id)
    if vote = vote_for_comment(comment_id) then
      return vote.flag == false
    else
      false
    end
  end

  private
  def vote_for_comment(comment_id)
    self.votes.find_by(comment_id: comment_id)
  end
end
