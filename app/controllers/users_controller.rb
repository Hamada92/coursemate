class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @questions = @user.questions
    @questions_he_answered = @user.questions_he_answered
  end

end



