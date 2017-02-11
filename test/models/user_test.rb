class LikeTest < ActiveSupport::TestCase

  test 'users can only be created with valid email' do 
    user = build(:user, email: "ahmad@mail.utoronto.ca")
    user2 = build(:user, email: "ahmad@gmail.com")
    assert user.valid?
    assert user2.invalid?
  end

end
