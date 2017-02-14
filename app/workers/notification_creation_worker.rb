class NotificationCreationWorker
  include Sidekiq::Worker

  def perform(comment_id, group_id, user_id)
    notification = Notification.new
    notification.source_type = "Group"
    notification.source_id = group_id
    notification.notifier_type = "Comment"
    notification.notifier_id = comment_id
    notification.user_id = user_id
    notification.save!
    notification
  end
end
