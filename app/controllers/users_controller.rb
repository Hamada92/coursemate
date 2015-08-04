class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :set_current_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @questions = @user.questions
    @questions_he_answered = @user.questions_he_answered
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user), notice: "Profile successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :avatar)
    end

    def set_current_user
      @user = current_user
    end

end



