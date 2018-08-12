require 'test_helper'
require "#{Rails.root}/lib/auth_token"

class AuthTokenTest < ActiveSupport::TestCase

  def setup
    create(:university)
    @user = create(:user)
  end

  test 'encode' do 
    token = AuthToken.new.encode(payload: { sub: @user.id })
    assert_equal true, token.present?
  end

  test 'find_user_from_token' do 
    #if it doesn't raise an error, it means it decoded it correctly and found the user, otherwise it would raise RecordNotFound
    token = JWT.encode({sub: @user.id}, Rails.application.secrets.secret_key_base, 'HS256')
    assert_nothing_raised { AuthToken.new.find_user_from_token(token) }
  end
end
