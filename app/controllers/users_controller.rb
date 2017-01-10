class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :set_current_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @questions = @user.questions.includes(:tags, :likes, :user)
    @questions_he_answered = @user.questions_he_answered.includes(:tags, :likes, :user)
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
      params.require(:user).permit(:username, :first_name, :last_name, :avatar_temp, :crop_x, :crop_y, :crop_w, :crop_h)
    end

    def set_current_user
      @user = current_user
      @s3_direct_post = S3_BUCKET.presigned_post(
        key: "uploads/#{Time.now.to_i}-#{SecureRandom.hex}/${filename}",
        success_action_status: '201',
        content_length_range: 0..User::MAX_AVATAR_UPLOAD_SIZE_MB*1024**2,
        acl: 'public-read'
      )
    end

end



