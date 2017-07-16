require 'test_helper'

class UserWithScoreTest < ActiveSupport::TestCase

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

    assert_equal 30, UserWithScore.first.score
  end

  test 'returns 0 if score is null due to no likes' do 
    question = create(:question, user: @user)
    assert_equal 0, UserWithScore.first.score
  end

  test 'only question like' do 
    question = create(:question, user: @user)
    create(:question_like, question: question)
    assert_equal 5, UserWithScore.first.score
  end

  test 'only answer like' do 
    answer = create(:answer, user: @user)
    create(:answer_like, answer: answer) 
    assert_equal 10, UserWithScore.first.score
  end

end
