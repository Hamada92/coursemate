require 'test_helper'

class Groups::CancelationsControllerTest < ActionController::TestCase

  def setup
    create(:university)
    @user = create(:user)
    create(:course)
    @group = create(:group, creator: @user)
    sign_in @user
  end

  test '#cancel marks the group as cancelled' do
    patch :cancel, params: { id: @group.id }
    assert_equal 'cancelled', @group.reload.status
  end
end
