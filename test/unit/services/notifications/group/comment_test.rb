require 'test_helper'

class Notifications::Group::CommentTest < ActiveSupport::TestCase

  def setup
    @group = create(:group)
    create(:group_enrollment, group: @group, user: @group.creator)
    create_list(:group_enrollment, 2, group: @group)
    @commenter = @group.users.last
    @comment = create(:group_comment, commentable: @group, user: @commenter)
    @service = Notifications::Group::Comment.new
  end

  test '#send sends notifications to the users in the group except the commenter' do 
    assert_difference 'NotificationCreationWorker.jobs.size', 2 do 
      @service.send(@group, @comment)
    end
  end
end

