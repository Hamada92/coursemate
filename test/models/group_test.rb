require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  def setup
    Rails.application.load_seed #populate universities
    @course = create(:course, name: 'cisc 121')
    @group = create(:group, course: @course)
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

  test 'date must be in future, or later time today' do 
    group = build(:group, day: Date.yesterday)
    group_2 = build(:group, day: Date.today, start_time: 1.hour.ago.strftime("%I:%M%p"))
    group_3 = build(:group)
    assert_raises(ActiveRecord::StatementInvalid) { group.save(validate: false) }
    assert_raises(ActiveRecord::StatementInvalid) { group.save(validate: false) }
    assert group_3.save(validate: false)
  end


  #application layer tests
  test '#cancel! updates the group status to cancelled' do 
    @group.cancel!
    assert_equal 'cancelled', @group.reload.status
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

  test 'invalid if no seats are less than 2' do 
    group = build(:group, seats: 1)

    assert group.invalid?, 'should be invalid but was valid'
  end

  test 'invalid if day in past' do 
    group = build(:group, day: 2.days.ago)
    assert group.invalid?, 'should be invalid but was valid'
  end

  test 'invalid if today but past time' do 
    group = build(:group, day: Date.today, start_time: 10.minutes.ago.strftime("%I:%M%p"))
    assert group.invalid?, 'should be invalid but was valid'
  end

  test 'groups status is set to active when created' do 
    group = create(:group)

    assert_equal 'active', group.status
  end
  
end
