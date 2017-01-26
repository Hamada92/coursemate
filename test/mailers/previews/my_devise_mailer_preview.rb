class MyDeviseMailerPreview < ActionMailer::Preview

  def test_activation_instructions
    MyDeviseMailer.confirmation_instructions(User.last, "faketoken", {})
  end

  def test_reconfirmation_instructions
    MyDeviseMailer.confirmation_instructions(User.first, "faketoken", {})
  end

  def test_reset_password_instructions
    MyDeviseMailer.reset_password_instructions(User.first, "faketoken", {})
  end

  def test_unlock_instructions
    MyDeviseMailer.unlock_instructions(User.first, "faketoken", {})
  end

  def test_password_change
    MyDeviseMailer.password_change(User.first, {})
  end

end