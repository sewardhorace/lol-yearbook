class Book < ActiveRecord::Base
  has_many :champions
  has_many :comments
end
