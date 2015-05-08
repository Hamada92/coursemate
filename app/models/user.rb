class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy

  def answered_questions
    Question.includes(:answers).where(answers: { user_id: self.id} )
    #or:
    #Question.joins(:answers).where("answers.user_id = ?", self.id).distinct
  end
end