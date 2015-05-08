class Question < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 10 }
  validates :body, presence: true
  belongs_to :user
  has_many :answers, dependent: :destroy

  def self.unanswered
    Question.includes(:answers).where(answers: { question_id: nil })
    # Plain SQL, but slower:
    #Question.where('id NOT IN (SELECT DISTINCT(question_id) FROM answers)')
  end
end
