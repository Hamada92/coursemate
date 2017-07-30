class GroupCommentStatusCreationService

  def initialize(comment)
    @comment = comment
  end

  def perform
    return unless users_to_notify
    GroupCommentStatus.transaction do 
      users_to_notify.each do |u|
        GroupCommentStatus.create(comment_id: @comment.id, user_id: u.id)
      end
    end
  end

  private

    def users_to_notify
      if @comment.group_id
        @comment.group.users.to_a - [@comment.user]
      end
    end
end
