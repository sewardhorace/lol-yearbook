class StaticChampion < ActiveRecord::Base
  #readonly
  has_many :champions, primary_key: "champion_id"
  validates :name, :champion_id, presence: true, uniqueness: true
end
