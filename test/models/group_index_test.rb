require 'test_helper'

class GroupIndexTest < ActiveSupport::TestCase
  def setup
    create(:university)
    create(:course)
    @group = create(:group)
    @group_2 = create(:group)
    @group_3 = create(:group, status: 'completed')
    @group_4 = create(:group, status: 'cancelled')
    create_list(:group_enrollment, 3, group: @group)
    create_list(:group_enrollment, 2, group: @group_2)
  end

  test 'returns the right number of groups' do 
    assert_equal 4, GroupIndex.count
    assert_equal @group_2.id, GroupIndex.first.id
  end

  test 'orders by the right columns' do 
    @group_2.cancel!

    groups = GroupIndex.all

    assert_equal [@group.id, @group_4.id, @group_3.id, @group_2.id], groups.pluck(:id)

  end

end
