require 'test_helper'

class UserCoursesControllerTest < ActionController::TestCase

  def setup
    @university = create(:university)
    @course = create(:course)
    @user = create(:user)
    sign_in @user
  end

  test '#create creates a new user course - course exists' do
    assert_difference 'UserCourse.count', 1 do
      assert_no_difference 'Course.count' do #course already exists, should use it
        post :create, params: {course_name: @course.name}, xhr: true
      end
    end
  end

  test "#create creates a new user course - course doesn't exist" do
    assert_difference 'UserCourse.count', 1 do
      assert_difference 'Course.count', 1 do 
        post :create, params: {course_name: 'cisc 134'}, xhr: true
      end
    end
  end

  test '#destroy deletes the specified user course' do
    create(:user_course, user: @user, course: @course)
    assert_difference 'UserCourse.count', -1 do
      post :destroy, params: {id: @course.name}, xhr: true
    end
  end

end
