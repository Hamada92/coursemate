class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @questions = @user.questions
    @questions_he_answered = @user.questions_he_answered
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "Image changed sucessfully"}
      else
        render :show
      end
    end
  end

  private 
    
    def user_params
      params.require(:user).permit(:avatar)
    end


end



