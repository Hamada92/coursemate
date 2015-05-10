class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable, only: [:create]
  before_action :set_comment, except: [:create]
  before_action :authorize, except: [:create]

  def edit
  end

  def create
    @comment = @commentable.comments.build(comment_params)
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

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @question, notice: "Comment successfully updated" }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @question, notice: 'Comment was deleted' }
    end
  end

  private

    def set_commentable
      if params[:question_id]
        @commentable = Question.find(params[:question_id])
        @question = @commentable
      elsif params[:answer_id]
        @commentable = Answer.find(params[:answer_id])
        @question = @commentable.question
      end
    end

    def set_built_comment
      @answer = @question.answers.build
      if @comment.commentable_type == 'Question'
        @question_comment = @comment
        @answer_comment = @answer.comments.new
      else
        @answer_comment = @comment
        @question_comment = @question.comments.new
      end
    end

    def set_comment
      @comment = Comment.find(params[:id])
      if @comment.commentable_type == 'Question'
        @question = @comment.commentable
      else
        @question = @comment.commentable.question
      end
    end 
        
    def comment_params
      params.require(:comment).permit(:body)
    end

    def authorize
      unless @comment.user == current_user
        flash[:alert] = "You are not allowed to edit someone else's comment"
        redirect_to @question
      end
    end

end
