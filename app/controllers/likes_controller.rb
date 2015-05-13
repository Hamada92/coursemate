class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable, only: [:create]
  before_action :set_like, only: [:destroy]
  before_action :restrict

  def create
    @like = @likeable.likes.build
    @like.user = current_user
    respond_to do |format|
      if @like.save
        format.html { redirect_to @question }
        format.js
      else
        format.html { render 'questions/show'}
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @like.update
        format.html { redirect_to @question}
        format.js
      else
        format.html { render 'questions/show' }
        format.js
      end
    end
  end

  private

    def set_likeable
      if params[:question_id]
        @likeable = Question.find(params[:question_id])
        @question = @likeable
      elsif params[:answer_id]
        @likeable = Answer.find(params[:answer_id])
        @question = @likeable.question
      end
    end

    def set_like
      @like = Like.find(params[:id])
      if @like.likeable_type == 'Question'
        @question = @like.likeable
      else
        @answer = @like.likeable
        @question = @answer.question
      end
    end 

    def restrict
      if @likeable.liked_by(current_user)
        redirect_to @question
      end
    end


end
