class GamesController < ApplicationController
  before_action :game_generate, only: [:index]
  before_action :set_game, only: [:show, :update]

  def index; end

  def show; end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    respond_to do |format|
      @game.update(game_params)
      format.html { redirect_to @game }
    end
  end

  private

  def set_game
    @game = Game.find_by_hashid(params[:id])
  end

  def game_generate
    @game ||= Game.generate_game
    @fake_authors = JSON.parse(@game.fake_authors)
    @all_authors = @fake_authors.push(@game.author).shuffle
  end

  def game_params
    params.require(:game).permit(:chosen_author)
  end
end
