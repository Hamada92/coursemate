class MyDeviseMailer < Devise::Mailer
 
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  layout 'mailer'

  def confirmation_instructions(record, token, opts={})
    if record.confirmed?
      if Rails.env.production?
        headers['X-SMTPAPI'] = '{ "category": ["email_reconfirmation"] }'
      end
      opts[:template_name] = 'reconfirmation_instructions'
      opts[:subject] = 'Confirm your new email address'
    else
      if Rails.env.production?
        headers['X-SMTPAPI'] = '{ "category": ["account_activation"] }'
      end
      opts[:template_name] = 'activation_instructions'
      opts[:subject] = 'Confirm your email address'
    end
    super
  end

  def reset_password_instructions(record, token, opts={})
    if Rails.env.production?
      headers['X-SMTPAPI'] = '{ "category": ["password_reset"] }'
    end
    opts[:subject] = 'Reset your password'
    super
  end

  def unlock_instructions(record, token, opts={})
    if Rails.env.production?
      headers['X-SMTPAPI'] = '{ "category": ["account_unlock"] }'
    end
    opts[:subject] = 'Unlock your account'
    super
  end

  def password_change(record, opts={})
    if Rails.env.production?
      headers['X-SMTPAPI'] = '{ "category": ["password_change"] }'
    end
    opts[:subject] = 'Your password was changed'
    super
  end

end
