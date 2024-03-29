require 'test_helper'

class GroupShowTest < ActiveSupport::TestCase

  def setup
    create(:university)
    create(:course)
    user = create(:user)
    @group = create(:group)
    enrollments = create_list(:group_enrollment, 4, group: @group)
    @attendees = enrollments.map(&:user_id)
  end

  test 'full is false if there are seats available' do 
    assert_equal false, GroupShow.first.full
  end

  test 'full is true when seats is equal to enrollments' do
    create(:group_enrollment, group: @group)
    assert_equal true, GroupShow.first.full
  end

  test 'returns the list of attendees' do 
    assert_equal 1, GroupShow.count
    assert_equal @attendees, GroupShow.first.attendees
  end

  test 'returns groups where the creator_id is null' do 
    build(:group, creator_id: nil).save(validate: false)
    assert_equal 2, GroupShow.count
  end

end
