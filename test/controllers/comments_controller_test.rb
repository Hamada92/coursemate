require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  test '#create invokes QuestionCommentNotification service class if commentable is a question' do 
    question = create(:question)
    user = create(:user)
    QuestionCommentNotification.any_instance.expects(:send).with(kind_of(Comment),question).returns("notification")
    sign_in user
    post :create, params: {question_id: question.id, comment: { body: "hi" }}, xhr: true
    assert_equal @response.status, 200
  end
end