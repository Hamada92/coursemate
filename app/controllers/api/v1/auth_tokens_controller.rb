class Api::V1::AuthTokensController < ApplicationController
  before_action :authenticate

  def create
    render json: auth_token, status: :created
  end

  private
    def authenticate
      begin
        unless user.valid_password? auth_params[:password]
          raise ActiveRecord::RecordNotFound # raising RecordNotFound is better for security.
        end
      rescue ActiveRecord::RecordNotFound => e
        Raven.capture_exception(e)
        head :not_found
      end
    end

    def user
      @user ||= User.find_by! email: auth_params[:email]
    end

    def auth_token
      AuthToken.new payload: { sub: user.id }
    end

    def auth_params
      params.require(:auth).permit(:email, :password)
    end
end
