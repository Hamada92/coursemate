require 'rails_helper'

describe 'it shows only the questions that belong to the university of the user' do 
  let! (:user) { User.create(email: 'test@test.com', password: 'testtest') }

  before :each do 
    @question1 = Question.create(title: 'Queens question', body: 'what is 2+2?', user: user, course_name: 'CISC', course_number: '123', university: "Queen's")
    @questions2 = Question.create(title: 'Western question', body: 'what is 2+2?', user: user, course_name: 'BIOL', course_number: '543', university: "Western")
  end

  it 'shows only the Queens question' do 
    login user
    p current_user
    visit root_path
    expect(page).to have_content('Queens question')
    expect(page).to_not have_content("Western question")
  end
end

