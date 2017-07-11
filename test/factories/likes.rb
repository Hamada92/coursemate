FactoryGirl.define do 
  factory :like do 
    user

    factory :answer_like do 
      answer
    end

    factory :question_like do 
      question
    end
  end
end
