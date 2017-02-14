class QuestionCommentNotification
  def send(comment, question)
    notification = comment.notifications.build()
    notification.user_id = comment.commentable.user_id
    notification.source = question
    notification.save!
    notification
  end
end
