require 'test_helper'

class GroupEnrollmentsControllerTest < ActionController::TestCase

  def setup
    create(:university)
    create(:course)
    @user = create(:user)
    @group = create(:group)
    sign_in @user
  end

  test '#create enrolls the current user in the specified group' do 
    assert_difference 'GroupEnrollment.count', 1 do
      post :create, params: {id: @group.id}, xhr: true
    end
  end

  test '#destroy un-enrolls the current user from the specified group' do 
    create(:group_enrollment, group: @group, user: @user)
    assert_difference 'GroupEnrollment.count', -1 do
      post :destroy, params: {id: @group.id}, xhr: true
    end
  end

end
