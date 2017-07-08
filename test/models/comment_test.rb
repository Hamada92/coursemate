require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    create(:university)
    create(:course)
  end

  test 'db should raise exception if more than one foreign key is specified' do 
    comment = build(:group_comment, question: create(:question))

    assert_raises(ActiveRecord::StatementInvalid) {comment.save(validate: false)}
  end

end
