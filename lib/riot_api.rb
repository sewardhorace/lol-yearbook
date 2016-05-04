module RiotApi
  def self.summoner_by_name(name, region="na")
    key = ENV['RIOT_KEY']
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

  def self.summoner_by_id(summoner_id, region="na")
    key = ENV['RIOT_KEY']
    url = "https://na.api.pvp.net/api/lol/#{region}/v1.4/summoner/#{summoner_id}?api_key=#{key}"
    data = self.request(url)
    if data.has_key? summoner_id then
      return data[summoner_id]
    else
      return false
    end
  end

  def self.champion_mastery(summoner_id, region="NA1")
    key = ENV['RIOT_KEY']
    url = "https://na.api.pvp.net/championmastery/location/#{region}/player/#{summoner_id}/champions?api_key=#{key}"
    data = self.request(url) #array expected
    example = data.first
    if example.has_key? "championId" then
      return data
    else
      return false
    end
  end

  def self.all_champions(region="na")
    key = ENV['RIOT_KEY']
    url = "https://global.api.pvp.net/api/lol/static-data/#{region}/v1.2/champion?champData=image&api_key=#{key}"
    data = self.request(url)
    if data.has_key? "data" then
      return data["data"]
    else
      return false
    end
  end

  def self.champion_by_id(id, region="na")
    key = ENV['RIOT_KEY']
    url = "https://global.api.pvp.net/api/lol/static-data/#{region}/v1.2/champion/#{id}?champData=image&api_key=#{key}"
    data = self.request(url)
    if data.has_key? "id" then
      return data
    else
      return false
    end
  end

  def self.champion_profile_img_url(img_name, version="6.9.1")
    url = "http://ddragon.leagueoflegends.com/cdn/#{version}/img/champion/#{img_name}.png"
  end

  def self.champion_splash_img_url(img_name)
    url = "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/#{img_name}_0.jpg"
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
