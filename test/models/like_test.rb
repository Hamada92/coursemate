class LikeTest < ActiveSupport::TestCase

  test 'Liking a question sends a notification to the question owner' do 
    question = create(:question)
    create(:question_like, likeable: question)

    assert_equal question.notifications.first.user_id, question.user_id
  end

end