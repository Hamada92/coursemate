class GroupEnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    enrollment = GroupEnrollment.new(user: current_user, group_id: params[:id])
    respond_to do |format|
      enrollment.save!
      format.js
    end
  end

  def destroy
    enrollment = GroupEnrollment.find_by(group_id: params[:id], user_id: current_user.id)
    enrollment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

    def set_group
      @group = Group.find(params[:id])
    end

end
