class Comment < ActiveRecord::Base

  has_many :notifications, dependent: :destroy
  belongs_to :question
  belongs_to :group
  belongs_to :user

  validates :body, presence: true
  
end
