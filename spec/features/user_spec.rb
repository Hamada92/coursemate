require "rails_helper"
describe 'go to dashboard' do 
  let!(:user1) { User.create(email: 'test1@test.com', password: 'testtest') }
  let!(:user2) { User.create(email: 'test2@test.com', password: 'tetstest') }
  let!(:user3) { User.create(email: 'test3@test.com', password: 'tetstest') }

  before :each do 
    @question1 = Question.create(title: 'user1question', body:'anything', user: user1)
    @question2 = Question.create(title: 'user2question', body:'anything', user: user2)
    @question3 = Question.create(title: 'user3question', body:'anything', user: user3)

    Answer.create(body: 'user1answer', user: user1, question: @question3)
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



