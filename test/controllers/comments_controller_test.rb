require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  def setup
    create(:university)
    create(:course)
    user = create(:user)
    sign_in user
  end

  test '#create invokes GroupCommentStatusServiceCreation service class if commentable is a group' do 
    group = create(:group)
    GroupCommentStatusCreationService.any_instance.expects(:perform)
    post :create, params: {group_id: group.id, comment: { body: "hi" }}, xhr: true
    assert_equal @response.status, 200
  end
end
