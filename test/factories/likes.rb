FactoryGirl.define do 
  factory :like do 
    user

    factory :answer_like do 
      association :likeable, factory: :answer
    end

    factory :question_like do 
      association :likeable, factory: :question
    end
  end
end