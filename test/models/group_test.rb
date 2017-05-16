require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  def setup
    @group = create(:group)
  end

  test '#cancel! updates the group status to cancelled' do 
    @group.cancel!
    assert_equal 'cancelled', @group.reload.status
  end
end
