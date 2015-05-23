require "rails_helper"
describe 'create new question' do 
  let!(:user)  { User.create(email: 'test@test.com', password: 'testtest') }
  
  before :each do 
    login user
  end

  it 'create a new question' do 
    visit '/questions/new'
    fill_in 'Title', with: 'test question'
    fill_in 'Body', with: 'what is your name?'
    select 'CISC', from: 'Course name'
    fill_in 'Course number', with: '110'
    click_button 'Post'
    expect(page).to have_content('what is your name?')
  end
end
