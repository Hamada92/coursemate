module GroupMethods

  def active?
    status == 'active'
  end

  def cancelled?
    status == 'cancelled'
  end

  def completed?
    status == 'completed'
  end

end
