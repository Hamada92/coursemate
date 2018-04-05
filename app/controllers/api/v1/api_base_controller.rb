require "#{Rails.root}/lib/auth_token"

class Api::V1::ApiBaseController < ActionController::Base

  def authenticate_api_user!
    head(:unauthorized) unless current_user
  end

  def current_user
    @current_user ||= AuthToken.new.find_user_from_token(token)
  end

  private

    def token
      params[:token] || token_from_request_headers
    end

    def token_from_request_headers
      unless request.headers['Authorization'].nil?
        request.headers['Authorization'].split.last
      end
    end

end
