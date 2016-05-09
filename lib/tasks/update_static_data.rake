desc "Update local static champion data from Riot API"
task :update_static_data => :environment do
  require "#{Rails.root}/lib/riot_api"
  require "#{Rails.root}/lib/quotes"
  quotes = ChampionQuotes.quotes.with_indifferent_access
  puts "Updating local static champion data from Riot API"
  puts "Fetching champion data..."
  champions = RiotApi.all_champions()
  puts "Champion data fetched"
  puts "Updating local database..."
  champions.each do |data|
    champ_data = data.last

    puts "Fetching img URLs..."
    key_name = champ_data["key"]
    profile_url = RiotApi.champion_profile_img_url(key_name)
    splash_url = RiotApi.champion_splash_img_url(key_name)

    puts "Fetching quote..."
    quote = quotes[key_name]
    puts quote

    if champ = StaticChampion.find_by(champion_id: champ_data["id"])
      puts "Updating local record:"
      champ.update(
        name: champ_data["name"],
        title: champ_data["title"],
        profile_url: profile_url,
        splash_url: splash_url,
        quote: quote
      )
    else
      puts "Creating new local record:"
      champ = StaticChampion.create(
        champion_id: champ_data["id"],
        name: champ_data["name"],
        title: champ_data["title"],
        profile_url: profile_url,
        splash_url: splash_url,
        quote: quote
      )
    end
    puts champ
  end
  puts "Local data up to date"
end
