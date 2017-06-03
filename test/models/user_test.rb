require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    Rails.application.load_seed #populate universities
  end

  test 'email must be present' do 
    user = build(:user, email: nil)

    assert user.invalid?, "should not allow user creation without email"
  end

  test 'users can only be created with valid email' do 
    user = build(:user, email: "ahmad@mail.utoronto.ca")
    user2 = build(:user, email: "ahmad@gmail.com")
    assert user.valid?, "user email should have been accepted but it wasn't"
    assert user2.invalid?, "user email shouldn't have been accepted but it was"
  end

  test 'university_domain is correctly set based on the email' do 
    user = create(:user)

    assert_equal 'queensu.ca', user.university_domain
  end
end
