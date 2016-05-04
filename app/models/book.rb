class Book < ActiveRecord::Base
  has_many :champions
  has_many :comments

  def update_summoner(summoner)
    if summoner then
      self.update(summoner_name: summoner["name"])
    end
    return self
  end

  def update_champions(champion_data)
    #TODO activerecord rollback catch
    champion_data.each do |mastery_data|
      champion_id = mastery_data["championId"]
      if champ = Champion.find_by(champion_id: champion_id, book_id: self.id) then
        champ.update(
          highest_grade: mastery_data["highestGrade"],
          mastery_points: mastery_data["championPoints"],
          mastery_level: mastery_data["championLevel"]
        )
      else
        Champion.create(
          book_id: self.id,
          champion_id: champion_id,
          highest_grade: mastery_data["highestGrade"],
          mastery_points: mastery_data["championPoints"],
          mastery_level: mastery_data["championLevel"]
        )
      end
    end
  end
end
