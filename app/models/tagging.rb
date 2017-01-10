class Tagging < ActiveRecord::Base
  
  belongs_to :question, touch: true
  belongs_to :tag

  after_destroy :cleanup_orphan_tags

  private

    def cleanup_orphan_tags
      if self.tag.questions.empty?
        self.tag.destroy
      end
    end
  
end
