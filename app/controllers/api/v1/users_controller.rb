class Api::V1::UsersController < Api::V1::ApiBaseController
  before_action :authenticate_api_user!

  def index
    render json: { api: true}
  end
end
