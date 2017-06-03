require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test 'name must be present' do 
    course = build(:course, name: nil)

    assert course.invalid?, "Should not allow a course without a name"
  end

  test 'university domain must be present' do
    course = build(:course, university: nil)

    assert course.invalid?, "Should not allow a course without a university domain"
  end

  test 'db raises an exception if foreign key does not exist' do 
    course = build(:course, university_domain: 'nothing.com')

    assert_raises(ActiveRecord::InvalidForeignKey, "Should have raised an invalidForeignKey exception but it didn't") { course.save(validate: false) } 
  end

  test 'db name and university domain should be a unique combination' do 
    course = create(:course)
    course_2 = build(:course, university: nil, university_domain: course.university_domain)

    assert_raises(ActiveRecord::RecordNotUnique) { course_2.save(validate: false) }
  end

  test 'name and university domain should be a unique combination' do 
    course = create(:course)
    course_2 = build(:course, university: nil, university_domain: course.university_domain)

    assert course_2.invalid?, "Should not allow duplicate combinations of name/domain"
  end
end
