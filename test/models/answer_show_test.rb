require 'test_helper'

class AnswerShowTest < ActiveSupport::TestCase
  def setup
    create(:university)
    create(:course)
    create_list(:answer, 2)
    build(:answer, user: nil).save(validate: false)
  end

  test 'returns correct number of rows' do
    assert_equal 3, AnswerShow.count
  end

end
