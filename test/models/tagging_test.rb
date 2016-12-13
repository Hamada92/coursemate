require 'test_helper'

class TaggingTest < ActiveSupport::TestCase

  test "deleting a uniqe taggings will delete its tag" do 
    question = create(:question)
    assert_equal Tag.count, 1

    question.destroy
    assert_equal Tag.count, 0

  end  

end