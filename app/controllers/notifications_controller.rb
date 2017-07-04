class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.paginate(per_page: 10, page: params[:page]).includes(:answer, like: [:likeable], comment: [:commentable])
  end

  def top_notifications
    @notifications = current_user.notifications.includes(:answer, like: [:likeable], comment: [:commentable]).limit(6)
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
