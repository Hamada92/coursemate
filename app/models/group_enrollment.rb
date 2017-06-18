class GroupEnrollment < ApplicationRecord
  self.primary_keys = [:user_id, :group_id]
  belongs_to :user
  belongs_to :group, counter_cache: :num_enrollments

  validate :group_not_full
  validate :group_active

  private

  def group_not_full
    if group.seats - group.num_enrollments == 0
      errors.add(:base, "Group is full")
    end
  end

  def group_active
    unless group.status == 'active'
      errors.add(:base, "Group is not active")
    end
  end

end
