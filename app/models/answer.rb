class Answer < ActiveRecord::Base
  validates :body, presence: true
  
  belongs_to :question
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  def liked_by user
    self.likes.where(user_id: user.id).any?
  end

end
