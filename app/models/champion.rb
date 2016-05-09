class Champion < ActiveRecord::Base
  belongs_to :book
  has_many :comments, dependent: :destroy
  has_one :static_data, class_name: "StaticChampion", primary_key: "champion_id"
  validates :book_id, :champion_id, presence: true

  def mastery_title
    return "Lvl #{self.mastery_level} Mastery"
  end

  def summoner_id
    return self.book.summoner_id
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

  def self.school_level

  end
end
