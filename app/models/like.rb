class Like < ActiveRecord::Base

  belongs_to :likeable, counter_cache: :num_likes, polymorphic: true
  belongs_to :user

end
