module Notifications
  module Group
    class Comment
      def send(group, comment)
        users = group.users.to_a - [comment.user] # don't notify the creator of the comment
        users.each do |user|
          NotificationCreationWorker.perform_async(comment.id, group.id, user.id)
        end
      end
    end
  end
end
