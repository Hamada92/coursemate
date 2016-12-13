class AvatarWorker
  include Sidekiq::Worker
  
  def perform(user_id)
    user = User.find(user_id)
    user.remote_avatar_url = user.avatar_temp
    user.processing_avatar = false
    user.avatar_temp = nil
    user.save!
  end

end