class LikesController < ApplicationController
  before: :authenticate_user!
  before: :set_likeable
  before: :restrict

  def create
    @like = @likeable.likes.build
    @like.user = current_user
    respond_to do |format|
      if @like.save
        format.js
      else
        format.js
      end
    end
  end

  def destroy
  end

  def set_likeable
    if params[:question_id]
      @likeable = Question.find(params[:question_id])
      @question = @likeable
    elsif params[:answer_id]
      @likeable = Answer.find(params[:answer_id])
      @question = @likeable.question
    end
  end

  def restric
    if @likeable.liked_by(current_user)
      redirect to @question
    end
  end


end
