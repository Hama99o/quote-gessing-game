class GamesController < ApplicationController
  before_action :game_generate, only: [:index]
  before_action :set_game, only: [:result, :update]

  def index; end

  def home; end

  def result; end

  def profile
    if @person
      @quotes = @person.games.where.not(chosen_author: nil).order(created_at: :desc)
      @correct_answer = @person.games.where(has_guessed: true).count
      @wrong_answer = @person.games.where(has_guessed: false).count
      @score = (@correct_answer - @wrong_answer) * 10
    else
      redirect_to home_path
    end
  end

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
    if @person
      @game ||= Game.generate_game(@person)
    else
      redirect_to home_path
    end
  end

  def game_params
    params.require(:game).permit(:chosen_author)
  end
end
