FactoryGirl.define do 
  factory :notification do 
    factory :answer_notification do 
      answer
    end
    factory :comment_notification do 
      comment {create(:group_comment)}
    end
  end
end


