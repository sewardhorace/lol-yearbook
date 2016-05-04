class StaticChampion < ActiveRecord::Base
  #readonly
  has_many :champions, primary_key: "champion_id"
end
