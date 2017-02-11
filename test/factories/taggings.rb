FactoryGirl.define do 
  factory :tagging do 
    question #this creates a question, which in turn creates a tagging
    tag
  end
end