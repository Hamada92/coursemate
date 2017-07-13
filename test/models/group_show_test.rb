require 'test_helper'

class GroupShowTest < ActiveSupport::TestCase

  def setup
    create(:university)
    create(:course)
    user = create(:user)
    @group = create(:group)
    q = create(:question, user: user)
    a = create(:answer, user: user)
    create(:question_like, question: q)
    create(:answer_like, answer: a)
  end

  test 'score should be (answer_likes * 10) + (question_likes * 5)' do 
    assert_equal GroupShow.find(@group.id).user_score, 15
  end

end
