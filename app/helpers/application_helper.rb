module ApplicationHelper
  def owner(post)
    current_user == post.user
  end
end
