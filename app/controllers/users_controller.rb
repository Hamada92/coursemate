class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_current_user, only: [:edit, :update]

  def index
    @users = User.with_score.all
  end

  def show
    @user = User.with_score.find(params[:id])
    @questions = @user.question_indices.limit(5).includes(:user)
    @questions_he_answered = @user.questions_he_answered.limit(5).includes(:user)
    @groups = @user.group_indices.limit(5).includes(:creator)
    @courses = @user.courses
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

  def questions
    @user = User.find(params[:id])
    @questions = @user.question_indices.paginate(per_page: 5, page: params[:page]).includes(:user)
  end

  def answers
    @user = User.find(params[:id])
    @questions = @user.questions_he_answered.paginate(per_page: 5, page: params[:page]).includes(:user)
  end

  def groups
    @user = User.find(params[:id])
    @groups = @user.group_indices.paginate(per_page: 4, page: params[:page]).includes(:creator)
  end

  private

    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :about_me, :avatar_temp, :crop_x, :crop_y, :crop_w, :crop_h)
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



