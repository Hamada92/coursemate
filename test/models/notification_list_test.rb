require 'test_helper'

class NotificationListTest < ActiveSupport::TestCase
  def setup
    create(:university)
    create(:course)
    @user = create(:user)
  end

  test 'returns the right number of notifications' do 
    question = create(:question, user: @user)
    comment = create(:question_comment, question: question)
    create(:comment_status, comment: comment, user: @user)
    create(:notification, comment: comment)

    answer = create(:answer, question: question)
    create(:notification, answer: answer)

    group_enrollment = create(:group_enrollment, user: @user)
    comment_2 = create(:comment, group: group_enrollment.group)
    create(:comment_status, comment: comment_2, user: @user)
    create(:notification, comment: comment_2)

    notifications = NotificationList.where(notified_user: @user.id)
    assert_equal notifications.count, 3
    assert_equal notifications.first.notified_user, @user.id
    assert_equal notifications.last.question_id, question.id
  end
end
