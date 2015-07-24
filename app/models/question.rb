class Question < ActiveRecord::Base

  default_scope { order(created_at: :desc) }

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true
  validates :body, presence: true
  validate :valid_tag_category
  validate :valid_tag

  after_save :create_tags

  attr_writer :tag_category
  attr_writer :tag_name
  
  def self.unanswered_with_tag id
    includes(:answers, :taggings).where(answers: { id: nil }).where(taggings: { tag_id: id})
  end

  def self.tagged_with id
    joins(:taggings).where(taggings: { tag_id: id })
  end

  def self.tagged_with_university university
    joins(:taggings, :tags).where(tags: { university: university })
  end

  def likes_by user
    self.likes.where(user_id: user.id)
  end

  def tag_category
    @tag_category || self.tags.first.category
  end

  def tag_name
    @tag_name || self.tags.first.name
  end

  private

    def valid_tag_category
      unless QuestionsHelper::CATEGORIES.include?(@tag_category)
        errors.add(:base, "Please use a valid question category")
      end
    end

    def valid_tag
      if @tag_category == "University Related"
        unless @tag_name == "General"
          errors.add(:base, "University related questions must be tagged with \'General\'")
        end
      elsif @tag_category == "Course Related"
        unless @tag_name =~ /\A *[A-Za-z0-9]+ +[A-Za-z0-9]+ *\Z/
          errors.add(:base, "A course must be composed of a course code and a course number seperated by a space")
        end
      elsif @tag_category == "Program Related"
        if @tag_name.blank?
          errors.add(:base, "Please enter a valid program")
        end
      end
    end

    def create_tags
      if @tag_category == "Course Related"
        @tag_name = @tag_name.strip
        @tag_name = @tag_name.gsub(/ +/," ")
        @tag_name = @tag_name.upcase
      elsif @tag_category == "Program Related"
        @tag_name = @tag_name.split.map(&:capitalize).join(' ')
      end
      old_tag = self.tags.first
      self.tags = [Tag.where(category: @tag_category, name: @tag_name, university: self.user.university).first_or_create]
      if not old_tag.nil? and old_tag.questions.empty?
        old_tag.destroy
      end
    end

end
