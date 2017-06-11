FactoryGirl.define do
  factory :group do 
    title 'group test'
    description 'study session'
    association :creator, factory: :user
    seats 5
    location 'Stauffer Library'
    day Date.tomorrow
    start_time (Time.now+60).strftime("%I:%M%p")
    course_name 'cisc 121'
    university_domain 'queensu.ca'

    factory :cancelled_group do
      status "cancelled"
      after(:build) { |obj| obj.class.skip_callback(:create, :before, :set_active) }
    end

    factory :completed_group do
      status "completed"
      after(:build) { |obj| obj.class.skip_callback(:create, :before, :set_active) }
    end
  end
end
