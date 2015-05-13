class Question < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 10 }
  validates :body, presence: true
  
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  def self.unanswered
    includes(:answers).where(answers: { id: nil })
  end

  def liked_by user
    self.likes.where(user_id: user.id).any?
  end


end
