require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  test 'index should return all questions along with their tags' do 
    create_list(:question, 2)
    create_list(:program_related_question, 2, user: create(:toronto_user) )
    
    get :index
    assert_equal 4, (assigns(:questions)).length
    assert_equal 2, (assigns(:universities)).length
  end
end