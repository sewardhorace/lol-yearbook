class StaticChampion < ActiveRecord::Base
  #readonly
  has_many :champions
  validates :name, presence: true, uniqueness: true
end
