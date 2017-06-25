class Question < ActiveRecord::Base

  default_scope { order(id: :desc) }

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :tag_name, presence: true
  validates :title, presence: true
  validates :body, presence: true
  validate :valid_tag_category, :valid_tag_university
  validate :valid_tag

  after_save :create_tags

  attr_writer :tag_university
  attr_writer :tag_category
  attr_writer :tag_name

  def self.tagged_with_university university
    joins(:taggings, :tags).where(tags: { university: university })
  end

  def like_by user_id
    likes.find{ |like| like.user_id == user_id }
  end

  def tag_university
    @tag_university || self.tags.first.university
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
        errors.add(:tag_category, "is not a valid category")
      end
    end

     def valid_tag_university
      unless UsersHelper::UNIVERSITIES.map{ |u| u[:name] }.include?(@tag_university)
        errors.add(:tag_university, "is not a valid university")
      end
    end

    def valid_tag
      if @tag_category == "University Related"
        unless @tag_name == "General"
          errors.add(:tag_name, "must be tagged with \'General\'")
        end
      elsif @tag_category == "Course Related"
        unless @tag_name =~ /\A *[A-Za-z0-9]+( )?+[A-Za-z0-9]+ *\Z/ 
          errors.add(:tag_name, "must be composed of a course code and a course number")
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
      self.tags = [Tag.where(name: @tag_name, category: @tag_category, university: @tag_university).first_or_create]
      if not old_tag.nil? and old_tag.questions.empty?
        old_tag.destroy
      end
    end

end
