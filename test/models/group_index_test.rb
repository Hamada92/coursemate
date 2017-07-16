require 'test_helper'

class GroupIndexTest < ActiveSupport::TestCase
  def setup
    create(:university)
    create(:course)
    @group = create(:group)
    create(:group_enrollment, group: @group)
    create(:group)
  end

  test 'returns all groups' do 
    assert_equal 2, GroupIndex.count
  end
end
