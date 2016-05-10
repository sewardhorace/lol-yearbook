class BooksController < ApplicationController
  def search
    name = search_params[:summoner_name]
    region = search_params[:region] || "NA"
    respond_to do |format|
      if summoner = RiotApi.summoner_by_name(name, region) then
        format.json {render json: {url: book_path(region, summoner['id'])}}
        format.html {redirect_to book_path(region, summoner['id'])}
      else
        format.json {render json: false}
        format.html {render "shared/not_found"}
      end
    end
    # #TODO more descriptive than '404'
  end

  def show
    summoner_id = params[:summoner_id]
    region = params[:region]
    book = Book.find_by(summoner_id: summoner_id, region: region)
    puts "BOOK"
    puts params
    puts book
    if !book then
      book = Book.create_from_summoner(RiotApi.summoner_by_id(summoner_id, region))
    end

    respond_to do |format|
      format.html do
        if @book = Book.includes(champions: [:static_data]).find(book.id) then
          render "books/show"
        else
          render "shared/not_found"
        end
      end
    end
  end

  def update
    summoner_id =  params[:summoner_id]
    respond_to do |format|
      if book = Book.find_by(summoner_id: summoner_id) then
        book.update_summoner(RiotApi.summoner_by_id(summoner_id, book.region))
        book.update_champions(RiotApi.champion_mastery(summoner_id, book.region))
        flash[:success] = 'Yearbook now up to date.'
        format.json {render json: true, status: :ok}
        format.html {redirect_to action: :show}
      else
        message = "An error occurred. Yearbook not updated"
        flash[:warning] = message
        format.json {render text: message, status: :internal_server_error}
        format.html {render "shared/not_found"}
      end
    end
    #TODO ^more descriptive error handling..
  end

  private
  def search_params
    params.require(:summoner_name)
    params.require(:region)
    params
  end
end
