class UsersController < ApplicationController
  def show
    @current_user = current_user
    @currect_answer = Game.where("user_id  = #{@current_user.id} AND has_guessed = true").count
    @false_answer = Game.where("user_id  = #{@current_user.id} AND has_guessed = false").count
    @score = (@currect_answer -   @false_answer) * 10
  end
end
