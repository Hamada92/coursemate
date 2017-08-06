require 'test_helper'

class CommentStatusCreationServiceTest < ActiveSupport::TestCase

  def setup
    create(:university)
    create(:course)
    @group = create(:group)
    create(:group_enrollment, group: @group, user: @group.creator)
  end

  test '#perform adds the right users to the CommentStatus table' do 
    comment = create(:group_comment, user: @group.creator, group: @group)
    comment_2 = create(:group_comment, group: @group)
    create_list(:group_enrollment, 3, group: @group)
    question = create(:question)
    comment_3 = create(:question_comment, question: question)
    comment_4 = create(:question_comment, question: question, user: question.user)
    answer = create(:answer)
    comment_5 = create(:answer_comment, answer: answer)
    comment_6 = create(:answer_comment, answer: answer, user: answer.user)

    #creator of comment is excluded
    assert_difference 'CommentStatus.count', 3 do 
      assert_difference 'Notification.count', 1 do
        CommentStatusCreationService.new(comment).perform
      end
    end  

    assert_difference 'CommentStatus.count', 4 do 
      CommentStatusCreationService.new(comment_2).perform
    end

    assert_difference 'CommentStatus.count', 1 do 
      CommentStatusCreationService.new(comment_3).perform
    end

    #comment by the question asker doesn't create a status
    assert_difference 'CommentStatus.count', 0 do 
      assert_difference 'Notification.count', 0 do 
        CommentStatusCreationService.new(comment_4).perform
      end
    end

    assert_difference 'CommentStatus.count', 1 do 
      assert_difference 'Notification.count', 1 do 
        CommentStatusCreationService.new(comment_5).perform
      end
    end

    #comment by the answer author on the answer doesn't create a status
    assert_difference 'CommentStatus.count', 0 do 
      CommentStatusCreationService.new(comment_6).perform
    end

  end
end
