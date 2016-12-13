FactoryGirl.define do
  factory :answer do 
    user
    question
    body "answer"
  end
end