require 'test_helper'

class QuestionShowTest < ActiveSupport::TestCase

  def setup
    create(:university)
    create(:course)
    user = create(:user)
    user_2 = create(:user)
    @q = create(:question, user: user)
    a = create(:answer, user: user)
    create(:question_like, question: @q)
    create(:answer_like, answer: a)
    create(:answer_like, answer: a, user: user_2)

  end

  test 'score should be (answer_likes * 10) + (question_likes * 5)' do 
    assert_equal 25, QuestionShow.find(@q.id).user_score
  end

end
