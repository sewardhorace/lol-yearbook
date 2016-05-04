class Champion < ActiveRecord::Base
  belongs_to :book
  has_many :comments
  has_one :static_data, class_name: "StaticChampion", foreign_key: "champion_id", primary_key: "champion_id"
end
