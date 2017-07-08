require 'test_helper'

class GroupEnrollmentTest < ActiveSupport::TestCase

  def setup
    create(:university)
    create(:course)
  end

  test 'Does not allow enrolling in a full group' do 
    group = create(:group, seats: 2)
    create_list(:group_enrollment, 2, group: group)
    enrollment = build(:group_enrollment, group: group)

    assert_not enrollment.valid?, 'Should not allow enrollments in full groups'
  end

  test 'Does not allow enrolling in a cancelled or completed group' do 
    cancelled_group = create(:cancelled_group)
    enrollment = build(:group_enrollment, group: cancelled_group)

    assert_not enrollment.valid?, 'Should not allow enrollments in cancelled groups'
  end

  test 'DB raises an error if user_id/group_id is not unique' do 
    group = create(:group)
    user = create(:user)
    first_enrollment = create(:group_enrollment, user: user, group: group)
    second_enrollment = build(:group_enrollment, user: user, group: group)

    assert_raises(ActiveRecord::RecordNotUnique) { second_enrollment.save(validate: false) }
  end
 
end
