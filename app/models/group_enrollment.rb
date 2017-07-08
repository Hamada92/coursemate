class GroupEnrollment < ApplicationRecord
  self.primary_keys = [:user_id, :group_id]
  belongs_to :user
  belongs_to :group

  validate :group_not_full
  validate :group_active

  private

  def group_not_full
    if group_info_for_enrollment(self).available_seats == 0
      errors.add(:base, "Group is full")
    end
  end

  def group_active
    unless group_info_for_enrollment(self).status == 'active'
      errors.add(:base, "Group is not active")
    end
  end

  def group_info_for_enrollment(enrollment)
   #get the group in which the user is trying to enroll, used to validate that group is not full and is active
   @group_info ||= Group.left_outer_joins(:group_enrollments).select('groups.id, groups.status, groups.seats - count(group_enrollments.group_id) as available_seats').group('groups.id').where(id: enrollment.group_id).first
 end

end
