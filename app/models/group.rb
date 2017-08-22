class Group < ApplicationRecord

  belongs_to :creator, class_name: 'User', required: true
  belongs_to :university, foreign_key: 'university_domain', required: true
  belongs_to :course, foreign_key: [:course_name, :university_domain], required: true
  
  has_many :group_enrollments, dependent: :destroy
  has_many :users, through: :group_enrollments
  has_many :comments, dependent: :destroy

  validates :title, :description, :starts_at, :ends_at, :location, :status, presence: true
  validates :seats, numericality: { only_integer: true, greater_than: 1 }
  validate :ends_at_greater_than_starts_at, if: lambda{|object| object.errors.empty?}

  def cancel!
    update_column(:status, 'cancelled')
  end

  private

    def ends_at_greater_than_starts_at
      if starts_at >= ends_at
        errors.add(:ends_at, "Must be greater than start time")
      end
    end
end
