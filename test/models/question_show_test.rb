require 'test_helper'

class QuestionShowTest < ActiveSupport::TestCase

  def setup
    create(:university)
    create(:course)
    user = create(:user)
    q = create(:question, user: user)
    likes = create_list(:question_like, 3, question: q)
    @likers = likes.map(&:user_id)
  end

  test 'returns the right number of likes' do 
    assert_equal 3, QuestionShow.first.num_likes
  end

  test 'returns an array of the likers' do 
    assert_equal @likers, QuestionShow.first.likers
  end

end
