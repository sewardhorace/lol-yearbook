class Champion < ActiveRecord::Base
  belongs_to :book
  has_many :comments
  has_one :static_data, class_name: "StaticChampion", foreign_key: "champion_id", primary_key: "champion_id"

  def mastery_title
    return "Lvl #{self.mastery_level} Mastery"
  end

  def school_level
    return case self.mastery_level
    when 5
      "Senior"
    when 4
      "Junior"
    when 3
      "Sophomore"
    when 2
      "Freshman"
    else
      "Incoming"
    end
  end
end
