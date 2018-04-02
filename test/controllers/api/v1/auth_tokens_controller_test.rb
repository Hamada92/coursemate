require 'test_helper'

class Api::V1::AuthTokensControllerTest < ActionController::TestCase

  def setup
    create(:university)
    @user = create(:user, password: '123123123', password_confirmation: '123123123')
  end

  test 'creates a new token' do 
    post :create, params: {auth: {email: @user.email, password: '123123123'}}
    response = JSON.parse(@response.body)
    assert response['jwt'], 'response doesnt have jwt key'
  end

  test 'raises RecordNotFound if either email or password are wrong' do 
    assert_raises(ActiveRecord::RecordNotFound) { post :create, params: {auth: {email: 'hi@fake.faky', password: '123123123'}} }
    assert_raises(ActiveRecord::RecordNotFound) { post :create, params: {auth: {email: @user.email, password: '0000000000'}} }
  end

end
