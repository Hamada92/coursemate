require 'test_helper'

class GroupEnrollmentsControllerTest < ActionController::TestCase

  def setup
    create(:university)
    create(:course)
    @user = create(:user)
    @group = create(:group)
    sign_in @user
  end

  test '#create enrolls the user in the group' do
    assert_difference 'GroupEnrollment.count', 1 do 
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
