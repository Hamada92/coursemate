class Like < ActiveRecord::Base

  validate :has_not_voted? 

  belongs_to :likeable, counter_cache: :num_likes, polymorphic: true
  belongs_to :user

  def has_not_voted?
    @likeable = self.likeable
    unless @likeable.likes_by(self.user).empty?
      errors.add(:base, "You can't vote twice on the same post") 
    end
  end
    

end
