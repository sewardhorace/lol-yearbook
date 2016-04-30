module RiotApi
  def self.summoner_by_name(name, region="na")
    key = ENV['riot_api_key']
    url_name = URI.escape(name)
    url = "https://na.api.pvp.net/api/lol/#{region}/v1.4/summoner/by-name/#{url_name}?api_key=#{key}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    summoner = JSON.parse(response)
    return summoner.values.first #API returns an object with the player's name as a key
  end

  def self.champions_mastery(summoner_id, region="NA1")
    key = ENV['riot_api_key']
    url = "https://na.api.pvp.net/championmastery/location/#{region}/player/#{summoner_id}/champions?api_key=#{key}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    champions = JSON.parse(response)
    return champions
  end

  def self.champion_by_id(id, region="na")
    key = ENV['riot_api_key']
    url = "https://global.api.pvp.net/api/lol/static-data/#{region}/v1.2/champion/#{id}?champData=image&api_key=#{key}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    info = JSON.parse(response)
    return info
  end

  def self.champion_image_url(img_name, version="5.2.1")
    url = "http://ddragon.leagueoflegends.com/cdn/#{version}/img/champion/#{img_name}"
  end
end
