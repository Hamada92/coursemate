FactoryGirl.define do
  factory :question do 
    user
    title "question title"
    body "question body"
    tag_name "MATH 101"
    tag_category "Course Related"

    factory :program_related_question do 
      tag_name "Engineering"
      tag_category "Program Related"
    end

    factory :university_related do 
      tag_name "General"
      tag_category "University Related"
    end
    
  end
end