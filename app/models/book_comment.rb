class BookComment < Comment
  belongs_to :book
  validates :user_id, presence: true
  validates :text, presence: true
  validates :book_id, presence: true
end
