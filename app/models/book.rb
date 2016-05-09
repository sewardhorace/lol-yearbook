class Book < ActiveRecord::Base
  has_many :champions, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :summoner_id, presence: true, uniqueness: true
  validates :summoner_name, presence: true

  def self.create_from_summoner(summoner)
    Book.create(summoner_id: summoner["id"], summoner_name: summoner["name"])
  end

  def update_summoner(summoner)
    if summoner then
      self.update(summoner_name: summoner["name"])
    end
    return self
    #TODO this sucks
  end

  def update_champions(champion_data)
    if !self.updateable then
      return false
    end
    book_id = self.id
    now = Time.now
    ActiveRecord::Base.transaction do
      champion_data.each do |mastery_data|
        champion_id = mastery_data["championId"]
        champ = Champion.find_by(champion_id: champion_id, book_id: book_id)
        if !champ then
          champ = Champion.new(champion_id: champion_id, book_id: book_id)
        end
        champ.update(
          highest_grade: mastery_data["highestGrade"],
          mastery_points: mastery_data["championPoints"],
          mastery_level: mastery_data["championLevel"],
          chest_earned: mastery_data["chestGranted"],
          updated_at: now
        )
      end
    end
    #TODO error handling catch
    #TODO more efficient mass update with raw query
  end

  def updateable
    if champion = self.champions.take then
      champion.updated_at < 1.day.ago
    else
      return true
    end
  end

  def next_update_time
    if champion = self.champions.take then
      champion.updated_at.to_datetime + 1.day
    else
      return DateTime.now
    end
  end
end
