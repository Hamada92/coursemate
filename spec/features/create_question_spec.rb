require "rails_helper"
describe 'create new question' do 
  let!(:user)  { User.create(email: 'test@test.com', password: 'testtest', university: 'Acadia University') }
  
  before :each do 
    login user
  end

  it 'create a new question' do 
    create_question
  end

  it 'does not create new tag if it already exists' do 
    Tag.create!(name: 'CISC 121', university: 'Acadia University', category: 'Course Related')
    create_question
  end


end
