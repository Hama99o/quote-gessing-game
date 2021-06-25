class GamesController < ApplicationController
  before_action :game_generate, only: [:index]
  before_action :set_game, only: [:result, :update]

  def index; end

  def home; end

  def result; end

  def profile
    @current_user = @person
    @currect_answer = Game.where("person_id  = #{@current_user.id} AND has_guessed = true").count
    @wrong_answer = Game.where("person_id  = #{@current_user.id} AND has_guessed = false").count
    @score = (@currect_answer - @wrong_answer) * 10
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
    @game ||= Game.generate_game(@person.id, @person_type)
  end

  def game_params
    params.require(:game).permit(:chosen_author)
  end
end
