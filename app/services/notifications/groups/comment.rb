module Notifications
  module Groups
    class Comment

      def initialize(comment)
        @comment = comment
      end

      def perform
        Notification.transaction do 
          users_to_notify.each do |u|
            Notification.create!(comment: @comment, user: u)
          end
        end
      end

      def users_to_notify
        if @comment.group_id
          @comment.group.users.to_a - [@comment.user]
        end
      end

    end
  end
end
