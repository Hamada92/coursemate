class Group < ApplicationRecord

  default_scope { order(id: :desc) }

  belongs_to :creator, class_name: 'User', required: true
  belongs_to :university, foreign_key: 'university_domain', required: true, counter_cache: :num_groups
  belongs_to :course, foreign_key: [:course_name, :university_domain], required: true
  
  has_many :group_enrollments, dependent: :destroy
  has_many :users, through: :group_enrollments
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, :description, :day, :start_time, :location, :status, presence: true
  validates :seats, numericality: { only_integer: true, greater_than: 1 }
  validate :day_in_future, if: lambda{|object| object.errors.empty?}
  validate :start_time_in_future, if: lambda{ |group| group.day == Date.today }
  validate :end_time_greater_than_start_time, if: lambda{|object| object.errors.empty?}

  def available_seats
    seats - num_enrollments
  end

  def is_full?
    available_seats == 0
  end

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

    def day_in_future
      if day < Date.today
        errors.add(:date, "Must be in the future")
      end
    end

    def start_time_in_future
      if start_time.present? && start_time.strftime("%I:%M%p") < Time.now.strftime("%I:%M%p")
        errors.add(:start_time, "Must be in the future")
      end
    end

    def end_time_greater_than_start_time 
      if start_time >= end_time
        errors.add(:end_time, "Must be greater than start time")
      end
    end
end
