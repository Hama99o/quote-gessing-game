class UsersController < ApplicationController
  def show
    @current_user = current_user
    @currect_answer = Game.where("user_id  = #{@current_user.id} AND has_guessed = true").count
    @wrong_answer = Game.where("user_id  = #{@current_user.id} AND has_guessed = false").count
    @score = (@currect_answer - @wrong_answer) * 10
  end
end
