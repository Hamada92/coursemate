class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: [:mark_read]
  before_action :authorize, only: [:mark_read]

  def index
    @notifications = current_user.notification_lists.paginate(per_page:10, page: params[:page])
  end

  def top_notifications
    @notifications = current_user.notification_lists.first(15)
    respond_to do |format|
      format.js
    end
  end

  def mark_read
    if @notification_list.notification_type == 'comment'
      CommentStatus.find_by(comment_id: @notification_list.notifier_id, user_id: current_user.id).update_column(:seen, true)
    elsif @notification_list.notification_type == 'answer'
      Answer.find(@notification_list.notifier_id).update_column(:seen, true)
    elsif @notification_list.notification_type == 'like'
      Like.find(@notification_list.notifier_id).update_column(:seen, true)
    end
    head :no_content
  end

  private

    def set_notification
      @notification_list = NotificationList.find_by(notifier_id: params[:id], notified_user: current_user.id)
    end

    def authorize
      unless @notification_list.notified_user == current_user.id
        head :unauthorized
      end
    end

end
