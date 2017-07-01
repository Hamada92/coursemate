class Like < ActiveRecord::Base

  has_many :notifications, as: :notifier, dependent: :destroy
  belongs_to :likeable, counter_cache: :num_likes, polymorphic: true, touch: true
  belongs_to :user

  validate :has_not_voted
  validate :does_not_own_post

  after_create :increase_user_score
  before_destroy :decrease_user_score

  def has_not_voted
    @likeable = self.likeable
    if @likeable.like_by(self.user_id)
      errors.add(:base, "You can't vote twice on the same post") 
    end
  end

  def does_not_own_post
    @likeable = self.likeable
    if @likeable.user == self.user
      errors.add(:base, "You can't vote on your own post") 
    end
  end

  private

    def increase_user_score
      update_user_score 1
    end

    def decrease_user_score
      update_user_score -1
    end

    def update_user_score sign
      user = self.likeable.user
      if self.likeable_type == 'Question'
        delta = 3
      else
        delta = 10
      end
      user.score += delta * sign
      user.save
    end
    
end
