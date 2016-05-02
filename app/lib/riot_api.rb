module RiotApi
  def self.summoner_by_name(name, region="na")
    key = ENV['riot_api_key']
    url_name = URI.escape(name)
    url = "https://na.api.pvp.net/api/lol/#{region}/v1.4/summoner/by-name/#{url_name}?api_key=#{key}"
    data = self.request(url)
    summoner = data.values.first #API returns an object with the player's name as a key
    if summoner.has_key? "id" then
      return summoner
    else
      return false
    end
  end

  def self.champions_mastery(summoner_id, region="NA1")
    key = ENV['riot_api_key']
    url = "https://na.api.pvp.net/championmastery/location/#{region}/player/#{summoner_id}/champions?api_key=#{key}"
    data = self.request(url) #array expected
    example = data.first
    if example.has_key? "championId" then
      return data
    else
      return false
    end
  end

  def self.champion_by_id(id, region="na")
    key = ENV['riot_api_key']
    url = "https://global.api.pvp.net/api/lol/static-data/#{region}/v1.2/champion/#{id}?champData=image&api_key=#{key}"
    data = self.request(url)
    if data.has_key? "id" then
      return data
    else
      return false
    end
  end

  def self.champion_image_url(img_name, version="5.2.1")
    url = "http://ddragon.leagueoflegends.com/cdn/#{version}/img/champion/#{img_name}"
  end

  private
  def self.request(url)
    uri = URI(url)
    begin
      response = Net::HTTP.get(uri)
      data = JSON.parse(response)
      return data
    rescue => e
      puts "ERROR"
      puts e.inspect
      return false
    end
  end
end
