class Answer < ActiveRecord::Base
  
  belongs_to :question
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  
  validates :body, presence: true

  def likes_by user
    self.likes.where(user_id: user.id)
  end

end
