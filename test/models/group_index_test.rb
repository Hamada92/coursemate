require 'test_helper'

class GroupIndexTest < ActiveSupport::TestCase
  def setup
    create(:university)
    create(:course)
    @group = create(:group)
    @group_2 = create(:group)
    create_list(:group_enrollment, 3, group: @group)
    create_list(:group_enrollment, 2, group: @group_2)
  end

  test 'returns the right number of groups' do 
    assert_equal 2, GroupIndex.count
    assert_equal @group_2.id, GroupIndex.first.id
  end
end
