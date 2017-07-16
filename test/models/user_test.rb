require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    create(:university)
    create(:course)
    @user = create(:user)
  end

  test 'with_score returns the right score' do 
    question = create(:question, user: @user)
    answer = create(:answer, user: @user)
    create_list(:question_like, 2, question: question) #user gets 10 points, 5 for each like of his question
    create_list(:answer_like, 2, answer: answer) #user gets 10 points

    score = User.with_score.find(@user.id).score

    assert_equal 30, score
  end

end
