require 'test_helper'

class QuestionIndexTest < ActiveSupport::TestCase

  def setup
    create(:university)
    create(:course)
    create(:question)
  end

  test 'returns course_url concatenation' do 
    assert_equal "CISC121,queensu.ca", QuestionIndex.first.course_url
  end

end
