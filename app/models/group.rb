class Group < ApplicationRecord
  belongs_to :creator, class_name: 'User', required: true
  belongs_to :university, foreign_key: 'university_domain', required: true
  belongs_to :course, foreign_key: [:course_name, :university_domain], required: true
  
  has_many :group_enrollments, dependent: :destroy
  has_many :users, through: :group_enrollments
  has_many :comments, as: :commentable, dependent: :destroy

  validates :seats, numericality: { only_integer: true, greater_than: 1 }
  validate :day_in_future, if: lambda{|object| object.errors.empty?}
  validate :start_time_in_future, if: lambda{ |group| group.day == Date.today }

  before_create :set_active

  default_scope { order(id: :desc) }

  def available_seats
    seats - num_group_enrollments
  end

  def is_full?
    available_seats == 0
  end

  def cancel!
    update!(status: 'cancelled')
  end

  def cancelled?
    status == 'cancelled'
  end

  def active?
    status == 'active'
  end

  def set_active
    self.status = 'active'
  end

  private

  def day_in_future
    if day < Date.today
      errors.add(:date, "Must be in the future")
    end
  end

  def start_time_in_future
    if start_time.present? && start_time < Time.now
      errors.add(:start_time, "Must be in the future")
    end
  end

end
