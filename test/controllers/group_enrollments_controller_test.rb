require 'test_helper'

class GroupEnrollmentsControllerTest < ActionController::TestCase

  def setup
    @user = create(:user)
    @group = create(:group)
    sign_in @user
  end

  test '#create enrolls the user in the group' do
    assert_difference 'GroupEnrollment.count', 1 do 
      post :create, params: { group_id: @group.id }, xhr: true
    end
  end

  test '#create does not enroll the user if the user is already enrolled' do 
    enrollment = create(:group_enrollment, user: @user, group: @group)

    assert_no_difference 'GroupEnrollment.count' do 
      post :create, params: { group_id: @group.id }, xhr: true
    end
  end

  test '#destroy unenrolls the user from the group' do 
    enrollment = create(:group_enrollment, user: @user, group: @group)

    assert_difference 'GroupEnrollment.count', -1 do 
      delete :destroy, params: { id: enrollment.id }, xhr: true
    end
  end

end
