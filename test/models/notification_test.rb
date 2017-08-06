require 'test_helper'

class NotificationTest < ActiveSupport::TestCase

  def setup
    create(:university)
    create(:course)
    @notification = create(:comment_notification)
  end

  test 'db should raise exception if more than one foreign key is specified' do 
    notification = build(:comment_notification, answer: create(:answer))

    assert_raises(ActiveRecord::StatementInvalid) { notification.save(Validate: false)}
  end

end
