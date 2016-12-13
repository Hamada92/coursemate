FactoryGirl.define do 
  factory :notification do 
    user

    factory :comment_notification do 
      association :notifier, factory: :question_comment
    end

    factory :answer_notification do 
      association :notifier, factory: :answer
    end
  end
end


