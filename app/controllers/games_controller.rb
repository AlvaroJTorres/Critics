class GamesController < ApplicationController
  before_action :set_game, only: %i[show edit update destroy add_genre remove_genre
                                    add_platform remove_platform]
  before_action :set_genre, only: %i[add_genre remove_genre]
  before_action :set_platform, only: %i[add_platform remove_platform]

  # GET /games
  def index
    @games = Game.all
    authorize Game
  end

  # GET /game/:id
  def show
    @involved_company = InvolvedCompany.new
  end

  # GET /games/new
  def new
    @game = authorize Game.new
    # authorize @game
  end

  # POST /games
  def create
    @game = Game.new(game_params)
    authorize @game

    if @game.save
      redirect_to games_path
    else
      render :new
    end
  end

  # GET /games/:id/edit
  def edit; end

  # PATCH/PUT /games/:id
  def update
    if @game.update(game_params)
      redirect_to games_path
    else
      render :edit
    end
  end

  # DELETE /games/:id
  def destroy
    @game.destroy
    redirect_to games_path
  end

  # POST /games/:id/add_genre   body: { genre_id: 1 }
  def add_genre
    @game.genres << @genre
    redirect_to @game # game_path(@game)
  end

  # DELETE /games/:id/remove_genre?genre_id:1
  def remove_genre
    @game.genres.delete(@genre)
    redirect_to @game
  end

  # POST /games/:id/add_platform   body: { platform_id: 1 }
  def add_platform
    @game.platforms << @platform
    redirect_to @game # game_path(@game)
  end

  # DELETE /games/:id/remove_platform?platform_id:1
  def remove_platform
    @game.platforms.delete(@platform)
    redirect_to @game
  end

  private

  def game_params
    params.require(:game).permit(:name, :summary, :release_date, :category, :rating, :cover, :parent_id)
  end

  def set_game
    @game = authorize Game.find(params[:id])
  end

  def set_genre
    @genre = Genre.find(params[:genre_id])
  end

  def set_platform
    @platform = Platform.find(params[:platform_id])
  end
end
