FactoryGirl.define do
  factory :group do 
    title 'group test'
    description 'study session'
    association :creator, factory: :user
    seats 5
    location 'Stauffer Library'
    admission_fee 3
    date Time.now.next_year
    start_time "2:30"
    tag_name "MATH 101"
    tag_university "Queen's University"
    status "active"
  end
end
