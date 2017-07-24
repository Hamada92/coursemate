FactoryGirl.define do
  factory :group do 
    course_name 'CISC121'
    university_domain 'queensu.ca'
    title 'group test'
    description 'study session'
    association :creator, factory: :user
    seats 5
    location 'Stauffer Library'
    starts_at 3.hours.from_now
    ends_at 6.hours.from_now
    status 'active'

    factory :cancelled_group do
      status "cancelled"
    end

    factory :completed_group do
      status "completed"
    end
  end
end
