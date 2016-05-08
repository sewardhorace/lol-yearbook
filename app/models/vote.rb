class Vote < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user
  validates :user_id, presence: true
  validates :comment_id, presence: true

  scope :up, lambda{where(flag: true)}
  scope :down, lambda{where(flag: false)}
end
