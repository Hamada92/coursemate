require 'test_helper'

class NotificationTest < ActiveSupport::TestCase

  def setup
    create(:university)
    create(:course)
    @notification = create(:comment_notification)
  end

  test 'notification is not read by default' do
    assert_equal false, @notification.read
  end

  test 'db should raise exception if more than one foreign key is specified' do 
    notification = build(:comment_notification, answer: create(:answer))

    assert_raises(ActiveRecord::StatementInvalid) { notification.save(Validate: false)}
  end

  test 'db should raise exception if user is null' do 
    notification = build(:comment_notification, user: nil)
    assert_raises(ActiveRecord::StatementInvalid) { notification.save(Validate: false)}
  end

end
