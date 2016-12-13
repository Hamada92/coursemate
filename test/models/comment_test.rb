require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test 'creating a comment creates a notification' do 
    assert_difference 'Notification.count' do 
      create(:question_comment)
    end
  end

  test 'deleting a comment deletes its notification' do 
    comment = create(:question_comment)

    assert_difference 'Notification.count', -1 do 
      comment.destroy
    end
  end

  test 'creating a comment sends a notification to the right user' do 
    comment = create(:question_comment)
    question_owner = comment.commentable.user

    assert_equal comment.notifications.first.user, question_owner
  end

  test 'creating a comment doesnt send a notification if the commenter is the question owner' do 
    question = create(:question)
    user = question.user

    assert_no_difference 'Notification.count' do 
      comment = create(:question_comment, user: user, commentable: question)
    end
  end

  test 'the notification belongs to the question' do 
    comment = create(:question_comment)

    assert_equal comment.notifications.first.question_id, comment.commentable_id
  end

end
