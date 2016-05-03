class BooksController < ApplicationController
  def search
    if summoner = RiotApi.summoner_by_name(search_params) then
      redirect_to book_path(summoner['id'])
    else
      raise ActionController::RoutingError.new('Not Found')
      #TODO actually create a 404 page
    end
  end

  def show
    summoner_id = params[:summoner_id]
    if @book = Book.find_by(summoner_id: summoner_id) then
      render "books/show"
    elsif summoner = RiotApi.summoner_by_id(summoner_id) then
      @book = Book.create(
        summoner_id: summoner["id"],
        summoner_name: summoner["name"]
      )
      render "books/show"
    else
      raise ActionController::RoutingError.new('Not Found')
      #TODO actually create a 404 page
    end
  end

  def update
    puts "UPDATE"
    summoner_id =  params[:summoner_id]
    book_id = params[:book_id]
    champions = RiotApi.champion_mastery(summoner_id)
    champions.each do |c_mastery|
      puts "C_MASTERY:"
      puts c_mastery
      champ = RiotApi.champion_by_id(c_mastery["championId"])
      url = RiotApi.champion_image_url(champ["image"]["full"])
      Champion.create(
        champion_id: champ["id"],
        book_id: book_id,
        name: champ["name"],
        title: champ["title"],
        img_url: url,
        highest_grade: c_mastery["highestGrade"],
        mastery_points: c_mastery["championPoints"],
        mastery_level: c_mastery["championLevel"]
      )
    end
    render json: true
  end

  private
    def search_params
      params.require(:summoner_name)
    end
end
