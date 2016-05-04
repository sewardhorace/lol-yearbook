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
    summoner_id =  params[:summoner_id]
    book = Book.find_by(summoner_id: summoner_id)
    book.update_summoner(RiotApi.summoner_by_id(summoner_id))
    #TODO ^this kind of sucks.. what if RiotApi call fails for some reason?
    update_champions(book)
    render json: true
  end

  private
  def search_params
    params.require(:summoner_name)
  end

  #TODO refactor into class method
  def create_champion(champion_id, book_id)
    if champ = Champion.find_by(champion_id: champion_id, book_id: book_id) then
      return champ
    elsif champ = Champion.create(champion_id: champion_id, book_id: book_id) then
      return champ
    # elsif data = RiotApi.champion_by_id(champion_id) then
    #   url = RiotApi.champion_image_url(data["image"]["full"])
    #   champ = Champion.new(
    #     champion_id: data["id"],
    #     book_id: book_id,
    #     name: data["name"],
    #     title: data["title"],
    #     img_url: url
    #   )
    #   return champ
    else
      return false
    end
  end

  #TODO refactor into class method
  def update_champions(book)
    if champions = RiotApi.champion_mastery(book.summoner_id) then
      champions.each do |mastery_data|
        champ = create_champion(mastery_data["championId"], book.id)
        champ.highest_grade = mastery_data["highestGrade"]
        champ.mastery_points = mastery_data["championPoints"]
        champ.mastery_level = mastery_data["championLevel"]
        champ.save
      end
    else
      return false
    end
  end
end
