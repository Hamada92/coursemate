FactoryGirl.define do
  factory :comment do 
    user
    body "comment"

    factory :group_comment do 
      group
    end

    factory :answer_comment do 
      answer
    end

    factory :question_comment do 
      question
    end
  end
end
