require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  def setup
    create(:university)
    create(:course)
    @user = create(:user, id: 5241) #need id value to be the same everytime to test the verifier.
  end
  test 'message includes an unsubscribe url' do
    message = UserMailer.new_groups(@user).deliver_now
    html_body = message.html_part.body.to_s
    assert_includes(html_body, "/subscriptions/BAhpAnkU--c50bd0485df035e13d443fadd82c2a28c27f29d2/unsubscribe")
  end
end
