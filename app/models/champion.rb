class Champion < ActiveRecord::Base
  belongs_to :book
  has_many :comments
end
