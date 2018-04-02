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
    assert_response(201)
  end

  test 'returns 404 if email is wrong' do 
    post :create, params: {auth: {email: 'hi@fake.faky', password: '123123123'}}
    assert_response(404)
  end

  test 'returns 404 if password is wrong' do 
    post :create, params: {auth: {email: @user.email, password: '00000'}}
    assert_response(404)
  end

end
