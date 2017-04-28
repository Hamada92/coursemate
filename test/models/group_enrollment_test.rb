require 'test_helper'

class GroupEnrollmentTest < ActiveSupport::TestCase

  test 'Does not allow enrolling in a full group' do 
    group = create(:group, seats: 1)
    create(:group_enrollment, group: group)
    enrollment = build(:group_enrollment, group: group)

    assert_not enrollment.valid?, 'Should not allow enrollments in full groups'
  end

  test 'Does not allow user to enroll twice' do 
    group = create(:group)
    user = create(:user)
    first_enrollment = create(:group_enrollment, user: user, group: group)
    second_enrollment = build(:group_enrollment, user: user, group: group)

    assert_not second_enrollment.valid?, 'Should not allow user to enroll twice'
  end
 
end
