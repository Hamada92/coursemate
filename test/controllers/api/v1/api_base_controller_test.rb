require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase

  def setup
    create(:university)
    @user = create(:user)
  end

  test 'without token' do 
    get :index
    assert_response(401)
  end

  test 'with token' do 
    token = AuthToken.new.encode(payload: { sub: @user.id } )
    request.headers.merge! "Authorization": "Bearer #{token}"
    get :index
    assert_response(200)
  end
end
