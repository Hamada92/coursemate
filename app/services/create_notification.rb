class CreateCommentNotification

  def initialize(comment:, answer:, like:)
    return unless comment || answer || like
    @comment = comment
  
end
