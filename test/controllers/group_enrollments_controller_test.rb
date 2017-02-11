require 'test_helper'

class GroupEnrollmentsControllerTest < ActionController::TestCase

  test '#create charges the card and enrolls the student' do 
    user = create(:user)
    group = create(:group)
    sign_in user

    Stripe::Charge.expects(:create).with({amount: group.admission_fee * 100, currency: 'cad', description: "payment for group  #{group.id}", source: '123123123123'}).returns(true)

    assert_difference 'GroupEnrollment.count', 1 do 
      post :create, params: { group_id: group.id, stripeToken: "123123123123" }
    end

    assert_redirected_to group
  end
end
