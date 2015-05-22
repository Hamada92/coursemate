require 'rails_helper'

describe 'it shows only the questions that belong to the university of the user' do 
  let! (:user) { User.create(email: 'test@test.com', password: 'testtest', university: "Queen's") }
  let! (:user2) { User.create(email: 'test2@test.com', password: 'testtest', university: "Western") }


  before :each do 
    @question1 = user.questions.create(title: 'Queens question', body: 'I am a queens question', course_name: 'CISC', course_number: '123')
    @questions2 = user2.questions.create(title: 'Western question', body: 'I am a western question', course_name: 'BIOL', course_number: '543')
  end

  it 'shows only the Queens question' do 
    login user
    visit root_path
    expect(page).to have_content('Queens question')
    expect(page).to_not have_content("Western question")
  end
end

