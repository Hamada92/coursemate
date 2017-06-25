require 'test_helper'

class GroupTest < ActiveSupport::TestCase

  def setup
    create(:university)
    create(:course)
  end

  #db tests raise exceptions
  test 'university_domain foreign key must be a valid reference' do 
    group = build(:group, university_domain: 'nothing.ca')
    assert_raises(ActiveRecord::InvalidForeignKey) { group.save(validate: false) }
  end

  test 'course_name/university_domain foreign key must be a valid reference' do 
    group = build(:group, course_name: 'invalid')

    assert_raises(ActiveRecord::InvalidForeignKey) { group.save(validate: false) } 
  end

  test 'creator_id foreign key must be a valid reference' do 
    group = build(:group, creator_id: 234234234)

    assert_raises(ActiveRecord::InvalidForeignKey) { group.save(validate: false) } 
  end

  test 'seats must be > 2' do 
    group = build(:group, seats: 1)

    assert_raises(ActiveRecord::StatementInvalid, "Seats must be at least 2") { group.save(validate: false) }
  end

  test 'date must be in future' do 
    group = build(:group, day: Date.yesterday)
    group_3 = build(:group, day: Date.today)
    assert_raises(ActiveRecord::StatementInvalid) { group.save(validate: false) }
    assert group_3.save(validate: false)
  end


  #application layer tests
  test '#cancel! updates the group status to cancelled' do 
    group = create(:group)
    group.cancel!
    assert_equal 'cancelled', group.reload.status
  end

  test 'invalid if no creator_id is present' do 
    group = build(:group, creator_id: nil)

    assert group.invalid?, 'should be invalid but was valid'
  end

  test 'invalid if no university_domain is present' do 
    group = build(:group, university_domain: nil)

    assert group.invalid?, 'should be invalid but was valid'
  end

  test 'invalid if no course_name is present' do 
    group = build(:group, course_name: nil)

    assert group.invalid?, 'should be invalid but was valid'
  end

  test 'invalid if seats are less than 2' do 
    group = build(:group, seats: 1)

    assert group.invalid?, 'should be invalid but was valid'
  end

  test 'invalid if day in past' do 
    group = build(:group, day: 2.days.ago)
    assert group.invalid?, 'should be invalid but was valid'
  end

  test 'invalid if today but past time' do 
    group = build(:group, day: Date.today, start_time: Time.now - 60)
    assert group.invalid?, 'should be invalid but was valid'
  end
end
