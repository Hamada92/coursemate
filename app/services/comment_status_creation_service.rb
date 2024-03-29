class CommentStatusCreationService

  def initialize(comment)
    @comment = comment
  end

  #creates a notification + comment_statuses
  def perform
    return unless users_to_notify.present?
    
    CommentStatus.transaction do 
      users_to_notify.each do |u|
        CommentStatus.create!(comment_id: @comment.id, user_id: u.id)
      end
      Notification.create!(comment_id: @comment.id)
    end
  end

  private

  def users_to_notify
    @users_to_notify ||=
      if @comment.group_id
        @comment.group.users.to_a - [@comment.user]
      elsif @comment.question_id
        Array.wrap(@comment.question.user) - [@comment.user]
      elsif @comment.answer_id
        Array.wrap(@comment.answer.user) - [@comment.user]
      end
  end
end
