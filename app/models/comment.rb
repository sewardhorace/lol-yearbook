class Comment < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  validates :user_id, presence: true
  validates :text, presence: true

  self.per_page = 10

  def time
    return time_ago_in_words(self.created_at)
  end
end
