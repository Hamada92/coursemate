FactoryGirl.define do
  factory :question do 
    user
    title "question title"
    body "question body"
    course_name 'CISC121'
    university_domain 'queensu.ca'
  end
end
