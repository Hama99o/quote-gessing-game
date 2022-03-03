class GamesController < ApplicationController
  before_action :game_generate, only: [:play]
  before_action :set_game, only: [:result, :update]
  before_action :person, only: [:profile]
  before_action :delete_unguessed_quote, only: [:profile]

  def play
    @page_title = 'Play'
  end

  def home
    @page_title = 'Home'
  end

  def result
    @page_title = 'Result'
  end

  def profile
    @page_title = 'Profile'
  end

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

  def person
    if @person
      @games = @person.resolved_games.page(params[:page])
    else
      redirect_to home_path
    end
  end

  def game_generate
    if @person
      @game ||= Game.generate_game(@person)
    else
      redirect_to home_path
    end
  end

  def delete_unguessed_quote
    unguessed_quote = Game.where(chosen_author: nil)
    unguessed_quote&.destroy_all
  end

  def game_params
    params.require(:game).permit(:chosen_author)
  end
end
