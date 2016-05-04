class Book < ActiveRecord::Base
  has_many :champions
  has_many :comments

  def update_summoner(summoner)
    if summoner then
      self.update(summoner_name: summoner["name"])
    end
    return self
  end
end
