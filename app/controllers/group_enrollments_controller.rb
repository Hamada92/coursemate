class GroupEnrollmentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_enrollment, only: [:destroy]
  before_action :authorize, only: [:destroy]

  def create
    @group = Group.find(params[:group_id])
    enrollment = GroupEnrollment.new(user: current_user, group: @group)
    respond_to do |format|
      if enrollment.save
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    @group = @enrollment.group
    @enrollment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def set_enrollment
    @enrollment = GroupEnrollment.find(params[:id])
  end

  def authorize
    unless @enrollment.user == current_user
      flash[:alert] = "You are not the owner of this enrollment"
      redirect_to @group
    end
  end
end
