require 'test_helper'

class GroupsControllerTest < ActionController::TestCase

  def setup
    Rails.application.load_seed #populate universities
    user = create(:user)
    sign_in user
  end

  def post_request(course)
    post :create, params: {university_domain: University.first.domain, course_name: course, 
      group: 
        {
          title: "hi",
           description: "hi",
           seats: 3,
           day: Date.tomorrow,
           start_time: 2.hours.from_now,
           location: 'Stauffer',
        }}
  end



  test '#create creates a group and a course' do 
    
    assert_difference 'Course.count', 1 do 
      post_request('cisc 121')
    end

    assert_difference 'Group.count', 1 do 
      post_request('cisc 121')
    end
  end


end
