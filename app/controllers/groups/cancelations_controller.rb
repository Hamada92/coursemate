class Groups::CancelationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  before_action :authorize

  def cancel
    @group.cancel!
    respond_to do |format|
      format.html { redirect_to @group, notice: 'Group was cancelled. Please leave a comment to let other students know' }
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def authorize
    unless current_user == @group.creator
      flash[:alert] = "You are not allowed to edit someone else's group."
      redirect_to @group
    end
  end
end
