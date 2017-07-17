require 'test_helper'

class CourseAutoCompletesControllerTest < ActionController::TestCase

  def setup
    create(:university)
    create(:course)
    create(:course, name: 'MATH132')
  end

  test 'returns a list of the courses in a partuclar university' do 
    get :index, params: {domain: 'queensu.ca'}
    response = JSON.parse(@response.body)
    assert_equal ["CISC121", "MATH132"], response
  end

end
