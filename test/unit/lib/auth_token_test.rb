require 'test_helper'

class AuthTokenTest < ActiveSupport::TestCase
  test 'it encodes the user id as a token' do 
    create(:university)
    user = create(:user)
    token = AuthToken.new(payload: { sub: user.id }).token
    #to do, decode it and test it contains user_id
  end
end
