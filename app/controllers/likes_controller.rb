class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable, only: [:create]
  before_action :set_like, only: [:destroy]

  def create
    @like = @likeable.likes.build
    @like.user = current_user
    respond_to do |format|
      if @like.save
        change_score 1
        format.html { redirect_to @question }
        format.js
      else
        format.html { render 'questions/show'}
        format.js
      end
    end
  end

  def destroy
    @like.destroy
    change_score -1
    respond_to do |format| 
      format.html { redirect_to @question }
      format.js
    end
  end

  private

    def set_likeable
      if params[:question_id]
        @likeable = Question.find(params[:question_id])
        @question = @likeable
      elsif params[:answer_id]
        @likeable = Answer.find(params[:answer_id])
        @answer = @likeable
        @question = @likeable.question
      end
    end

    def set_like
      @like = Like.find(params[:id])
      if @like.likeable_type == 'Question'
        @question = @like.likeable
        @likeable = @question
      else
        @likeable = @like.likeable
        @answer = @likeable
        @question = @answer.question
      end
    end

    def change_score points
      if @like.likeable_type == 'Question'
        points *= 5
      elsif @like.likeable_type == 'Answer'
        points *= 10
      end
      @like.likeable.user.score += points
      @like.likeable.user.save
    end

end
