class GroupTagging < ApplicationRecord
  belongs_to :group
  belongs_to :group_tag

  after_destroy :cleanup_orphan_tags

  private

    def cleanup_orphan_tags
      if self.group_tag.groups.empty?
        self.group_tag.destroy
      end
    end
  
end
