require 'rails_helper'
describe 'create a new answer for a question' do 
  let!(:user)  { User.create(email: 'test@test.com', password: 'testtest', university: 'Acadia University') }

  it 'answers a question' do 
    login user
    create_question
    fill_in 'Body', with: 'It is 4 man!'
    click_button 'Post'
    expect(page).to have_content 'It is 4 man!'
  end
end
