require 'rails_helper'
describe 'create a new answer for a question' do 
  let! (:user) { User.create(email: 'test@test.com', password: 'testtest') }

  before :each do 
    @question = Question.create(title: 'test question', body: 'what is 2+2?', user: user)
  end

  it 'answers a question' do 
    login user
    visit "/questions/#{@question.id}"
    fill_in 'Body', with: 'It is 4 man!'
    click_button 'Post'
    expect(page).to have_content 'what is 2+2?'
    expect(page).to have_content 'It is 4 man!'
  end
end
