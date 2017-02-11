require 'test_helper'

class TaggingTest < ActiveSupport::TestCase

  test "deleting a uniqe taggings will delete its tag" do 
    Question.any_instance.stubs(:create_tags) #don't create tags automatically (model method)
    tagging = create(:tagging)
    assert_equal Tag.count, 1

    tagging.destroy
    assert_equal Tag.count, 0

  end  

end