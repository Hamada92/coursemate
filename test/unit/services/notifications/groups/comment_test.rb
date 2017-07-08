require 'test_helper'

class Notifications::Groups::CommentTest < ActiveSupport::TestCase
  def setup
    create(:university)
    create(:course)
    @user = create(:user)
    @group = create(:group, creator: @user)
    create(:group_enrollment, user: @user, group: @group) #enroll owner
    create_list(:group_enrollment, 2, group: @group)
  end

  test '#users_to_notify returns the users who should be notified' do
    @comment = create(:group_comment, group: @group)
    service = Notifications::Groups::Comment.new(@comment)
    assert_equal @group.users, service.users_to_notify
  end

  test '#users_to_notify excludes the user who created the comment' do 
    @comment = create(:group_comment, user: @user, group: @group)
    service = Notifications::Groups::Comment.new(@comment)
    refute_includes service.users_to_notify, @user
  end

  test '#perform creates a notification for each user' do 
    @comment = create(:group_comment, group: @group)
    assert_difference 'Notification.count', 3 do 
      service = Notifications::Groups::Comment.new(@comment).perform
    end
  end

end
