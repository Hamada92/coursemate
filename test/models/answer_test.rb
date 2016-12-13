require 'test_helper'

class AnswerTest < ActiveSupport::TestCase

  test 'creating an answer creates a notification' do 
    assert_difference 'Notification.count', 1 do 
      create(:answer)
    end
  end

  test 'creating an answer sends a notification to the right user' do 
    answer = create(:answer)

    assert_equal answer.notifications.first.user, answer.question.user
  end

  test 'deleting an answer deletes the notification' do 
    answer = create(:answer)

    assert_difference 'Notification.count', -1 do 
      answer.destroy
    end
  end

end
