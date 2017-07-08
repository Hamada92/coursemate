require 'test_helper'

class GroupsControllerTest < ActionController::TestCase

  def setup
    Rails.application.load_seed #populate universities
    user = create(:user)
    @university_domain = University.first.domain
    sign_in user
  end

  def post_request(university_domain, course)
    post :create, params: {university_domain: university_domain , course_name: course, 
    group: 
      {
        title: "hi",
        description: "hi",
        seats: 3,
        day: Date.tomorrow,
        start_time: 2.hours.from_now,
        end_time: 3.hours.from_now,
        location: 'Stauffer',
    }}
  end

  test '#create creates a group and a course' do 
    
    assert_difference 'Course.count', 1 do 
      post_request(@university_domain, 'cisc 121')
    end

    assert_difference 'Group.count', 1 do 
      post_request(@university_domain, 'cisc 121')
    end
  end

  test '#create find the existing course and uses it' do 
    course = create(:course, name: 'hist 234', university_domain: @university_domain)

    assert_no_difference 'Course.count' do 
      post_request(@university_domain, 'hist 234')
    end

    assert_equal course, Group.last.course
    assert_redirected_to Group.last
  end

end
