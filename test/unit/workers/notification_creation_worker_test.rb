require 'test_helper'

class NotificationCreationWorkerTest < ActiveSupport::TestCase

  def setup
    @worker = NotificationCreationWorker.new
    @group = create(:group)
    @comment = create(:group_comment)
    @user = @group.creator
  end

  test '#perform creates a notification with the right attributes' do 
    notification = @worker.perform(@comment.id, @group.id, @user.id)
    assert_equal notification.user, @user
    assert_equal notification.source, @group
    assert_equal notification.notifier, @comment
  end
end
