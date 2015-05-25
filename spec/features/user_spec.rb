require "rails_helper"
describe 'go to dashboard' do 
  let!(:user1) { User.create(email: 'test1@test.com', password: 'testtest', university: "Acadia University") }
  let!(:user2) { User.create(email: 'test2@test.com', password: 'tetstest', university: "Acadia University")}
  let!(:user3) { User.create(email: 'test3@test.com', password: 'tetstest', university: "Acadia University")}

  before :each do 
    @question1 = user1.questions.create!(title: 'user1question', body:'anything', "tags_attributes"=>{"0"=>{category: "Course Related", name: "CISC 121", university: "Acadia University"}})
    @question2 = user2.questions.create!(title: 'user2question', body:'anything', "tags_attributes"=>{"0"=>{category: "Course Related", name: "CISC 121", university: "Acadia University"}})
    @question3 = user3.questions.create!(title: 'user3question', body:'anything', "tags_attributes"=>{"0"=>{category: "Course Related", name: "CISC 121", university: "Acadia University"}})
    user1.answers.create(body: 'answer', question: @question3)
  end



  it "shows only user1's questions and answers in the dashboard" do
    login user1
    visit "/users/#{user1.id}"
    expect(page).to have_content('user1question')
    expect(page).to_not have_content('user2question')
    expect(page).to have_content('user3question')
  end

  it "shows only user2's questions and answers in the dashboard" do
    login user2
    visit "/users/#{user2.id}"
    expect(page).to have_content('user2question')
    expect(page).to_not have_content('user1question')
  end

end



