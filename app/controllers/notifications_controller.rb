class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.includes(comment: [:commentable]).order('id DESC').limit(6)
    respond_to do |format|
      format.js
    end
  end

  def mark_read
    notification = Notification.find(params[:id])
    notification.update_column(:read, true)
    head :no_content
  end

end
