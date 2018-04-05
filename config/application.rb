require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AnswerMe
  class Application < Rails::Application

    config.active_job.queue_adapter = :sidekiq

    config.active_record.time_zone_aware_types = [:datetime]

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      user_name: 'apikey',
      password: ENV['SENDGRID_APIKEY'],
      domain: ENV['DOMAIN'],
      address: 'smtp.sendgrid.net',
      port: 587,
      authentication: :plain,
      enable_starttls_auto: true
    }

    #sentry error monitoring
    Raven.configure do |config|
      config.dsn = 'https://8605d6d4c1b14cc1b8d47a3ec9526635:73e0eed5df6d444aae2a6f965e10945e@sentry.io/199656'
    end

    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Add the services folder into the autoloaded paths.
    config.autoload_paths << "#{Rails.root}/services"
    config.autoload_paths << "#{Rails.root}/workers"
    config.autoload_paths << "#{Rails.root}/lib"

  end
end
