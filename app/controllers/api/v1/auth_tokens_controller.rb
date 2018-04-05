class Api::V1::AuthTokensController < Api::V1::ApiBaseController
  before_action :authenticate

  def create
    render json: { jwt: auth_token}.to_json, status: :created
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
      AuthToken.new.encode payload: { sub: user.id }
    end

    def auth_params
      params.require(:auth).permit(:email, :password)
    end
end
