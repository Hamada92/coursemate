class Api::V1::UsersController < ApplicationController
  def index
    render json: { api: true}
  end
end
