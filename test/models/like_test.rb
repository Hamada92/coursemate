require 'test_helper'

class LikeTest < ActiveSupport::TestCase

  def setup
    create(:university)
    create(:course)
  end

  test 'db should raise exception if more than one foreign key is specified' do 
    like = build(:answer_like, question: create(:question))

    assert_raises(ActiveRecord::StatementInvalid) {like.save(validate: false)}
  end

  test 'db raises if someone votes twice' do 
    user = create(:user)
    question = create(:question)
    like = create(:question_like, question: question, user: user)
    like_2 = build(:question_like, question: question, user: user)

    assert_raises(ActiveRecord::StatementInvalid) {like_2.save(validate: false)}
  end

  test 'doesnt allow voting on your own post' do 
    user = create(:user)
    question = create(:question, user: user)
    like = build(:question_like, question: question, user: user)

    assert_raises(ActiveRecord::RecordInvalid) {like.save!}
  end

end
