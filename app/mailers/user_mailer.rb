class UserMailer < ApplicationMailer
  include MessageProcessor

  helper :application 

  layout 'mailer'

  def new_groups(user)
    mail(to: user.email, subject: 'There are new study groups for your courses')
  end

end
