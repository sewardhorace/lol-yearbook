class ChampionComment < Comment
  belongs_to :champion
  validates :champion_id, presence: true
end
