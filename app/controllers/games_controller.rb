class GamesController < ApplicationController
  before_action :set_game, only: %i[show edit update destroy]
  before_action :quote_api
  before_action :form_data, only: %i[new index]
  # GET /games or /games.json
  def index
    @game = Game.new(@form_data)
  end

  # GET /games/1 or /games/1.json
  def show; end

  # GET /games/new
  def new
    @game = Game.new(@form_data)
  end

  # GET /games/1/edit
  # def edit; end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params)
    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  # def update
  #   respond_to do |format|
  #     if @game.update(game_params)
  #       format.html { redirect_to @game, notice: 'Game was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @game }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @game.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  def form_data
    @form_data = {
      quote: @quote,
      author: @author,
      fake_author: @fake_author,
      api_id: @quote_id
    }
  end

  def quote_api
    @all_data = QuoteApi.new
    @api_server = @all_data.api_server
    @author = @api_server['quoteAuthor']
    @fake_author = @all_data.ren_authors
    @quote = @api_server['quoteText']
    @quote_id = @api_server['_id']
    @all_author = @fake_author.push(@author).shuffle
  end

  # Only allow a list of trusted parameters through.
  def game_params
    params.require(:game).permit(:user_id, :quote, :author, :fake_author, :api_id, :chosen_author, :score)
  end
end
