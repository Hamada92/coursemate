class Group < ApplicationRecord

  default_scope { order(id: :desc) }

  belongs_to :creator, class_name: 'User', required: true
  belongs_to :university, foreign_key: 'university_domain', required: true
  belongs_to :course, foreign_key: [:course_name, :university_domain], required: true
  
  has_many :group_enrollments, dependent: :destroy
  has_many :users, through: :group_enrollments
  has_many :comments, dependent: :destroy

  validates :title, :description, :starts_at, :ends_at, :location, :status, presence: true
  validates :seats, numericality: { only_integer: true, greater_than: 1 }
  validate :starts_at_is_today_or_later, if: lambda{|object| object.errors.empty?}
  validate :ends_at_greater_than_starts_at, if: lambda{|object| object.errors.empty?}

  def cancel!
    update_column(:status, 'cancelled') # skip validation, date may not be in future
  end

  def cancelled?
    status == 'cancelled'
  end

  def active?
    status == 'active'
  end

  private

    def starts_at_is_today_or_later
      if starts_at.present? && starts_at < Time.now
        errors.add(:starts_at, "Must be in the future")
      end
    end

    def ends_at_greater_than_starts_at
      if starts_at >= ends_at
        errors.add(:ends_at, "Must be greater than start time")
      end
    end
end
