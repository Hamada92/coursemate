require 'test_helper'

class NotificationTest < ActiveSupport::TestCase

  def setup
    create(:university)
    create(:course)
    @notification = create(:notification)
  end

  test 'notification is not read by default' do
    assert_equal false, @notification.read
  end
end
