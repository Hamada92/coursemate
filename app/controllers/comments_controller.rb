class CommentsController < ApplicationController
before_action :set_commentable

  def create
    @comment = @commentable.comments.build(comments_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @question, notice: "Comment created for #{@commentable.class}" }
      else
        set_built_comment
        format.html { render 'questions/show' }  
      end
    end
  end
  private

    def set_commentable
      if params[:question_id]
        @commentable_type = :question
        @commentable = Question.find(params[:question_id])
        @question = @commentable
      elsif params[:answer_id]
        @commentable_type = :answer
        @commentable = Answer.find(params[:answer_id])
        @question = @commentable.question
      end
    end

    def set_built_comment
      @answer = @question.answers.build
      if @commentable_type == :question
        @question_comment = @comment
        @answer_comment = @answer.comments.build
      else
        @answer_comment = @comment
        @question_comment = @question.comments.build
      end
    end
        
    def comments_params
      params.require(:comment).permit(:body)
    end


end
