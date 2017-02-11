require 'test_helper'

class QuestionCommentNotificationTest < ActiveSupport::TestCase
  def setup
    @question = create(:question)
    @comment = create(:question_comment) 
    @service = QuestionCommentNotification.new
  end

  test 'creates a notification with the right params' do
    notification = @service.send(@comment, @question)
    assert_equal notification.source_id, @question.id
    assert_equal notification.user_id, @comment.commentable.user_id
  end
end
