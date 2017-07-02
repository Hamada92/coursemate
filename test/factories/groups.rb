FactoryGirl.define do
  factory :group do 
    course_name 'CISC121'
    university_domain 'queensu.ca'
    title 'group test'
    description 'study session'
    association :creator, factory: :user
    seats 5
    location 'Stauffer Library'
    day Date.tomorrow
    start_time (Time.now+60).strftime("%I:%M%p")
    end_time (Time.now+120).strftime("%I:%M%p")
    status 'active'

    factory :cancelled_group do
      status "cancelled"
    end

    factory :completed_group do
      status "completed"
    end
  end
end
