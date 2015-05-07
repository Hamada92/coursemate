class Question < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 10 }
  validates :body, presence: true
  belongs_to :user
  has_many :answers, dependent: :destroy
end
