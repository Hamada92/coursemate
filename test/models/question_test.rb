require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

  test "creating question creates its tag if the tag doesn't exist" do 
    assert_difference 'Tag.count', 1 do 
      create(:question)
    end
  end

  test "creating question doesn't create new tags if the tag already exists" do 
    create(:question)

    assert_no_difference 'Tag.count' do 
       create(:question)
     end
  end

   test "creating question creates new tagging everytime" do 
    create(:question)

    assert_difference 'Tagging.count', 1 do 
       create(:question)
     end
  end

  

end