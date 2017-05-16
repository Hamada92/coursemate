class Group < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  
  has_many :group_enrollments, dependent: :destroy
  has_many :users, through: :group_enrollments
  has_many :group_taggings, dependent: :destroy
  has_many :group_tags, through: :group_taggings
  has_many :comments, as: :commentable, dependent: :destroy

  validates :tag_university, :tag_name, :title, :description, :seats, :location, :date, :start_time, presence: true
  validates :seats, numericality: { only_integer: true }
  validate :date_in_future
  validate :start_time_in_future, if: lambda{ |group| group.date == Date.today }
  validate :valid_tag
  validate :valid_tag_university

  before_create :set_active
  after_save :create_tags

  attr_writer :tag_name
  attr_writer :tag_university

  default_scope { order(id: :desc) }

  def self.tagged_with_university university
    joins(:group_taggings, :group_tags).where(group_tags: { university: university })
  end

  def tag_name
    @tag_name || self.group_tags.first.name
  end

  def tag_university
    @tag_university || self.group_tags.first.university
  end

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

  def date_in_future
    if date && date < Date.today #check if date exists because rails runs custom validation even if the presence true validation didn't pass
      errors.add(:date, "Must be in the future")
    end
  end

  def start_time_in_future
    if start_time.present? && start_time.to_time < Time.now
      errors.add(:start_time, "Must be in the future")
    end
  end

  def valid_tag
    if @tag_name.present? #so this validation doesn't run from the rails console when we go @group.update(seats: 2)
      unless @tag_name =~ /\A *[A-Za-z0-9]+( )?+[A-Za-z0-9]+ *\Z/
        errors.add(:tag_name, "must be composed of a course code and a course number")
      end
    end
  end

  def valid_tag_university
    if @tag_university.present? && !UsersHelper::UNIVERSITIES.map{ |u| u[:name] }.include?(@tag_university)
      errors.add(:tag_university, "is not a valid university")
    end
  end

  def create_tags
    if @tag_name.present? #create tags only if the virtual attribute exists, when we run the rails console, they don't exist
      @tag_name = @tag_name.strip
      @tag_name = @tag_name.gsub(/ +/," ")
      @tag_name = @tag_name.upcase
      
      old_tag = self.group_tags.first
      self.group_tags = [GroupTag.where(name: @tag_name, university: @tag_university).first_or_create]
      if not old_tag.nil? and old_tag.groups.empty?
        old_tag.destroy
      end
    end
  end

end
