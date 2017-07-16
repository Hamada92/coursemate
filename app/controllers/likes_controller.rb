class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like, only: [:destroy]

  def create
    @like = Like.new(user_id: current_user.id)
    if params[:type] == 'question'
      @like.question_id = params[:id]
    elsif params[:type] == 'answer'
      @like.answer_id = params[:id]
    end

    respond_to do |format|
      if @like.save
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    @like.destroy
    respond_to do |format|
      format.js
    end
  end

  private

    def set_like
      if params[:type] == 'question'
        @like = Like.find_by(question_id: params[:id], user_id: current_user.id)
      elsif params[:type] == 'answer'
        @like = Like.find_by(answer_id: params[:id], user_id: current_user.id)
      end
    end

end
