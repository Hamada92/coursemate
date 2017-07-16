class UserWithScore < ApplicationRecord
  self.primary_key = 'id'

  has_many :answer, foreign_key: [:answer_id]

  mount_uploader :avatar, AvatarUploader

end
