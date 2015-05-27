class Like < ActiveRecord::Base

  belongs_to :likeable, counter_cache: :num_likes, polymorphic: true
  belongs_to :user

  validate :has_not_voted? 
  validate :does_not_own_post?

  def has_not_voted?
    @likeable = self.likeable
    unless @likeable.likes_by(self.user).empty?
      errors.add(:base, "You can't vote twice on the same post") 
    end
  end

  def does_not_own_post?
    @likeable = self.likeable
    if @likeable.user == self.user
      errors.add(:base, "You can't vote on your own post") 
    end
  end
    
end
