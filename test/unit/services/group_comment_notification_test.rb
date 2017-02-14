require 'test_helper'

class GroupCommentNotificationTest < ActiveSupport::TestCase

  def setup
    @group = create(:group)
    create(:group_enrollment, group: @group, user: @group.creator)
    create_list(:group_enrollment, 2, group: @group)
    @commenter = @group.users.last
    @comment = create(:group_comment, commentable: @group, user: @commenter)
    @service = GroupCommentNotification.new
  end

  test '#send should notifiy all users enrolled in the group except the commenter' do 
    assert_equal 0, NotificationCreationWorker.jobs.size
    @service.send(@group, @comment)
    assert_equal 2, NotificationCreationWorker.jobs.size
  end
end


