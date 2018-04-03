class GroupEnrollment < ApplicationRecord
  self.primary_keys = [:user_id, :group_id]
  belongs_to :user
  belongs_to :group
  belongs_to :group_index, foreign_key: [:group_id]

  #ideally these validations should be on the DB layer, but laziness is strong.
  validate :group_not_full
  validate :group_active

  private

  def group_not_full
    if group_info_for_enrollment(self).available_seats == 0
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  def group_active
    unless group_info_for_enrollment(self).status == 'active'
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  def group_info_for_enrollment(enrollment)
   #get the group in which the user is trying to enroll, used to validate that group is not full and is active
   @group_info ||= Group.left_outer_joins(:group_enrollments).select('groups.id, groups.status, groups.seats - count(group_enrollments.group_id) as available_seats').group('groups.id').where(id: enrollment.group_id).first
 end

end
