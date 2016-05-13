class Reply < Comment
  belongs_to :comment
  validates :comment_id, presence: true
end
