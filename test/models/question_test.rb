require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

  def setup
    create(:university)
    create(:course)
    @question = create(:question)
    create(:answer, question: @question)
  end

  test 'cant delete questions with answers' do 
    assert_raises(ActiveRecord::InvalidForeignKey) {@question.destroy}
  end

end
