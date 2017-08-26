class NotificationsController < ApplicationController
  before_action :authenticate_user!

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
    case params[:type]
    when 'comment'
      CommentStatus.find_by(comment_id: params[:id], user_id: current_user.id).update_column(:seen, true)
    when 'like'
      Like.find(params[:id]).update_column(:seen, true)
    when 'answer'
      Answer.find(params[:id]).update_column(:seen, true)
    end
    head :no_content
  end

  def authorize
    #to do
  end
end
