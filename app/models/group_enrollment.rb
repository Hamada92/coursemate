class GroupEnrollment < ApplicationRecord
  belongs_to :user
  belongs_to :group, counter_cache: :num_group_enrollments

  validate :group_not_full
  validate :group_active
  validates :user_id, uniqueness: { scope: :group_id }

  private

  def group_not_full
    if group.seats - group.num_group_enrollments == 0
      errors.add(:base, "Group is full")
    end
  end

  def group_active
    unless group.status == 'active' 
      errors.add(:base, "Group is not active")
    end
  end

end
