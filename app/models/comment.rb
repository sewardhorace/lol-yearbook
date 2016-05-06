class Comment < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  validates :user_id, presence: true
  validates :text, presence: true
end
