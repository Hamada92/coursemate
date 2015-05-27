class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:university, :user_name]
    devise_parameter_sanitizer.for(:account_update) << [:university, :first_name, :last_name, :user_name]
  end

end
