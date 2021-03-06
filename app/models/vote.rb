class Vote < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user
  validates :user_id, :comment_id, presence: true
  validates :comment_id, uniqueness: { scope: :user_id }

  scope :up, lambda{where(flag: true)}
  scope :down, lambda{where(flag: false)}
end
