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
    click_button 'Post'
    expect(page).to have_content('what is your name?')
  end
end



def login(user)
  page.driver.post user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
end