require 'test_helper'

class GroupCommentStatusCreationServiceTest < ActiveSupport::TestCase

  def setup
    create(:university)
    create(:course)
    @group = create(:group)
    create(:group_enrollment, group: @group, user: @group.creator)
  end

  test '#perform adds the right users to the GroupCommentStatus table' do 
    comment = create(:group_comment, user: @group.creator, group: @group)
    comment_2 = create(:group_comment, group: @group)
    create_list(:group_enrollment, 3, group: @group)

    #creator of comment is excluded
    assert_difference 'GroupCommentStatus.count', 3 do 
      GroupCommentStatusCreationService.new(comment).perform
    end

    assert_difference 'GroupCommentStatus.count', 4 do 
      GroupCommentStatusCreationService.new(comment_2).perform
    end

  end
end
