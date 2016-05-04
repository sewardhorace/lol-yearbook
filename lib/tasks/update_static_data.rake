desc "Update local static champion data from Riot API"
task :update_static_data => :environment do
  require "#{Rails.root}/lib/riot_api"
  puts "Updating local static champion data from Riot API"
  puts "Fetching champion data..."
  champions = RiotApi.all_champions()
  puts "Champion data fetched"
  puts "Updating local database..."
  champions.each do |data|
    champ_data = data.last
    puts "Fetching img URL..."
    url = RiotApi.champion_image_url(champ_data["image"]["full"])
    if champ = StaticChampion.find_by(champion_id: champ_data["id"])
      puts "Updating local record:"
      champ.update(
        name: champ_data["name"],
        title: champ_data["title"],
        img_url: url
      )
    else
      puts "Creating new local record:"
      champ = StaticChampion.create(
        champion_id: champ_data["id"],
        name: champ_data["name"],
        title: champ_data["title"],
        img_url: url
      )
    end
    puts champ
  end
  puts "Local data up to date"
end
